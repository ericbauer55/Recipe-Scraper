# Recipe-Scraper
R project to scrape recipe details from online food sites and then populate relevant data frames

## Directory Legend
1. **data**: raw data is stored here including...
    * "links_*.txt" = links to recipes of interest (ex: main dishes, lunch, appetizers)
    * "recipe_site_css_selectors.csv" = list of css selectors, by website, to acquire name, ingredients, etc.
2. **tmp**: temporary R datatypes can be dumped here (ex: list with name, ingredients, etc.)
3. **output**: any analysis outputs in a non-R format are exported here. Includes .txt, .csv, and images
