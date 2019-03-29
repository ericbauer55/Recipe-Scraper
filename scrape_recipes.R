scrape_recipes <- function(dir,txtfile){
    library(readr)
    library(rvest)
    css_sel <- file.path(src_dir,"recipe_site_css_selectors.csv")
    css_sel <- read_csv(css_sel)
    
    linkfile <- file.path(dir,txtfile)
    linkfile <- read_lines(linkfile) # read the links into a character vector
    
    recipes <- list()
    count <- 1
    for(link in linkfile){
        # check which website from the CSS LUT is being scraped
        css_site <- css_sel[sapply(css_sel$website, function(y) grepl(y,link)), ]
        # read the html
        h <- read_html(link)
        tmp <- list(url=link)
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
    recipes
}