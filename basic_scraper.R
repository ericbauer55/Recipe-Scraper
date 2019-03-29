###################################
# Setup
###################################
setwd("~/R_Programming/R_code/Recipe-Scraper")
src_dir <- file.path(getwd(),"data")
library(dplyr)
library(readr)
library(rvest)


###################################
# Read LUT for CSS selectors
###################################
filenames <- list.files(src_dir)
filenames
css_sel <- file.path(src_dir,"recipe_site_css_selectors.csv")
css_sel <- read_csv(css_sel)

###################################
# Scrape HTML
###################################
linkfile1 <- file.path(src_dir,"links_lunch_dishes.txt")
lf1 <- read_lines(linkfile1) # read the links into a character vector

recipes <- list()
count <- 1
for(link in lf1){
    # check which website from the CSS LUT is being scraped
    css_site <- css_sel[sapply(css_sel$website, function(y) grepl(y,link)), ]
    # read the html
    h <- read_html(link)
    
    # scrape the html into a list
    for(node in names(css_site)[-1]){ # [-1] removes website name
        if(node == "ingredients"){
            inglist <- h %>% html_nodes(css_site[[node]]) %>% html_text() # scrape each node
            tmp[[node]] <- inglist[!(inglist=="Add all ingredients to list")] # for allrecipes.com... 
        } else {
            tmp[[node]] <- h %>% html_node(css_site[[node]]) %>% html_text() # scrape first node 
        }
    }
    recipes[[count]] <- tmp
    count <- count + 1
}

recipes[[1]]
