parse_recipe <- function(rec){
    # rec = tidy tibble containing recipe name, url, cook/prep time, and ingredients as columns
    #   |--> NOTE: the ingredient columns are not specific yet. Meaning 'ing_01' occurs in all inputs
    # RETURNS a tidy tibble with parsed cook/prep times as well as specifically labeled ingredient columns
    #   |--> ex: column 'ing_01' could contain '1 cup 2% milk'. This column is renamed 'milk' with value = '1 cup 2%'
    source("parse_ingredient.R")
    library(stringr)
    ### Parse the time-related columns, convert all character descriptions to integers in units of 'minutes'
    #pattern1 <- "^(\\d)?\\s*h?\\s*(\\d{1,2})\\s*m$"
    #pattern2 <- "^?((?=(\\d)?\\s*h)(\\d)?\\s*h\\s*(\\d{1,2})\\s*m|(\\d{1,2})\\s*m)$"
    # pattern1 makes "20 m" turn into h=2, m=0 rather than h=0, m=20
    # pattern2 attempts to fix this with a conditional but isn't fully worked out yet
    
    pattern3 <- regex("^
                ?((?=\\d{1,2}\\s*h)                         # conditional: did a number (00-99) precede the unit 'h'?
                      (\\d{1,2})\\s*h\\s*(\\d{1,2})\\s*m    # |-->if-then: look for 'DD h DD m'
                      |(\\d{1,2})\\s*m                      # |-->if-else: look for 'DD m'
    )$", comments = TRUE)
    # Prep Time
    m <- str_match(rec$prep_time, pattern3)
    bad = is.na(m[1,4])
    m[bad,4] <- m[bad,5] # if the 'if-then' didn't match, use the result for if-else. Worst case: copies NA to NA
    rec$prep_time <- as.integer(m[1, 4])
    # Cook Time
    m <- str_match(rec$cook_time, pattern3)
    bad = is.na(m[1,4])
    m[bad,4] <- m[bad,5] # if the 'if-then' didn't match, use the result for if-else. Worst case: copies NA to NA
    rec$cook_time <- as.integer(m[1, 4])
    # Total Time
    m <- str_match(rec$total_time, pattern3)
    bad = is.na(m[1,4])
    m[bad,4] <- m[bad,5] # if the 'if-then' didn't match, use the result for if-else. Worst case: copies NA to NA
    rec$total_time <- as.integer(m[1, 4])
    
    ### Parse each ingredient, rename generic columns to specific ingredient names
    for(ing in 1:rec$ing_count){
        plist <- parse_ingredient(rec[[sprintf("ing_%02d",ing)]])
    }
    
    rec
    
}