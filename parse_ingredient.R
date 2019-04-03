parse_ingredient <- function(ingredient){
    # ingredient = character description of quantity, ingredient and any relevant modifier
    #   |--> ex: '1/3 cup green onions, chopped' 
    # RETURNS a list specifying the quantity, measurement unit, ingredient name and modifier
    #   |--> ex: the input example would result in 'quantity=1/3','unit=cup','ing_name=green onions',
    #            'modifier=chopped'
    parsed_ing = list(ing_name="", quantity="", unit="", modifiers="")
    
    parsed_ing
}