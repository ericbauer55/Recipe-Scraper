###################################
# Setup
###################################
setwd("~/R_Programming/R_code/Recipe-Scraper")
source("scrape_recipes.R")
src_dir <- file.path(getwd(),"data")

filenames <- list.files(src_dir)
filenames


###################################
# Scrape HTML recipes
###################################
r2 <- scrape_recipes(src_dir,"links_lunch_dishes.txt")

###################################
# Parse ingredients lists
###################################
rec_tab <- 0 # table of recipe information