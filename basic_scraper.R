###################################
# Setup
###################################
setwd("~/R_Programming/R_code/Recipe-Scraper")
source("scrape_recipes.R")
source("tidy_recipe.R")
source("parse_recipe.R")
source("recipe_distances.R")
source("recipe_proximities.R")
library(tibble)
library(stringr)
src_dir <- file.path(getwd(),"data")

filenames <- list.files(src_dir)
filenames


###################################
# Scrape HTML recipes
###################################
rec <- scrape_recipes(src_dir,"links_main_dishes.txt")

###################################
# Tidy & Parse ingredients lists
###################################
#rec1tab <- rec[[1]] %>% tidy_recipe()  %>% parse_recipe()
#rec2tab <- rec[[2]] %>% tidy_recipe()  %>% parse_recipe()
#rec1tab
rectab <- lapply(rec, function(x) x %>% tidy_recipe()  %>% parse_recipe())

###################################
# Combine Tidy Recipes into Table
###################################
# combine rectab elements with a full join
rectab <- rectab %>% purrr::reduce(full_join)
write_csv(rectab, "tmp/recipe_table.csv")

###################################
# Compute Distance between Recipes
###################################
rectab <- read_csv("tmp/recipe_table_annotated.csv") # read in the hand annotated recipes
adjm_dist <- recipe_distances(rectab)   # weight = number of different ingredient inclusions
adjm_prox <- recipe_proximities(rectab) # weight = number of common ingredients

