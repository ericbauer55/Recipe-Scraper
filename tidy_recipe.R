tidy_recipe <- function(recList){
    # recList = list object containing recipe name, url, cook/prep time, and ingredient list
    # RETURNS a tidy tibble object where each row is one observation (recipe), each column is one variable
    tidyrec = tibble()
    for(col in names(recList)){
        if(col == "ingredients"){
            next # we will deal with columnizing the ingredients next 
        } 
        tidyrec[1,col] <- recList[[col]] # create a column named 'col' from list names, populated with list value at 'col'
    }
    # record the number of ingredients
    tidyrec[1,"ing_count"] <- length(recList$ingredients)
    # record the unparsed ingredient list
    for(ing in 1:length(recList$ingredients)){
        col <- str_c("ing_",sprintf("%02d",ing)) # creates ingredient number as column name, in format "ing_01"
        tidyrec[1,col] = recList$ingredients[ing] # create ingredient column populated with unparsed description
    }
    
    # Return the tidy version of the recipe list object
    tidyrec
}