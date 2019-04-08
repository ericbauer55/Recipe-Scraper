recipe_distances <- function(rectab){
    # rectab = tibble containing [metadata | ingredients] composite matrix for all recipes
    # return = adjacency matrix weighted by the distance between recipes
    #   |--> dist(rec_i,rec_j) = # of ingredients that are different
    # create an adjacency matrix to store the distances between recipe i to recipe j for all i,j in length(recipes)
    adjm <- matrix(nrow=nrow(rectab), ncol=nrow(rectab)) # create a blank weighted adjancency graph
    combos <- t(combn(nrow(rectab),2)) # create a list of all non-repeating recipe combinations
    # determine the start and end indices of the sparse ingredient matrix
    ing_start_index <- which(names(rectab)=="ing_count") + 1 
    ing_indices <- ing_start_index:ncol(rectab)
    # determine the number of ingredients that are different between each recipe combination
    for(i in 1:nrow(combos)){
        combo <- combos[i,] 
        x <- is.na(rectab[combo[1],ing_indices]) # which ingredients are NA, thus not used in the recipe?
        y <- is.na(rectab[combo[2],ing_indices]) # which ingredients are NA, thus not used in the recipe?
        z <- xor(x,y)                            # between the two recipes, is ingredient k's inclusion different?
        adjm[combo[1],combo[2]] <- sum(z)
    }
    adjm
}