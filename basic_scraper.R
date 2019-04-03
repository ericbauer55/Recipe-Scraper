###################################
# Setup
###################################
setwd("~/R_Programming/R_code/Recipe-Scraper")
source("scrape_recipes.R")
source("tidy_recipe.R")
source("parse_recipe.R")
library(tibble)
library(stringr)
src_dir <- file.path(getwd(),"data")

filenames <- list.files(src_dir)
filenames


###################################
# Scrape HTML recipes
###################################
rec <- scrape_recipes(src_dir,"links_lunch_dishes.txt")

###################################
# Tidy & Parse ingredients lists
###################################
rec1tab <- rec[[1]] %>% tidy_recipe()  %>% parse_recipe()
rec2tab <- rec[[2]] %>% tidy_recipe() # %>% parse_recipe()
rec1tab
###################################
# Combine Tidy Recipes into Table
###################################
# combine rec1tab and rec2tab with a full join

###################################
# Compute Distance between Recipes
###################################

