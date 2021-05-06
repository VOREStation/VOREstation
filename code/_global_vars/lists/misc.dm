GLOBAL_LIST_INIT(speech_toppings, list("|" = "i", "+" = "b", "_" = "u"))
GLOBAL_LIST_EMPTY(meteor_list)

/// List of wire colors for each object type of that round. One for airlocks, one for vendors, etc.
GLOBAL_LIST_EMPTY(wire_color_directory) // This is an associative list with the `holder_type` as the key, and a list of colors as the value.

// Reference list for disposal sort junctions. Filled up by sorting junction's New()
GLOBAL_LIST_EMPTY(tagger_locations)

<<<<<<< HEAD
GLOBAL_LIST_INIT(char_directory_tags, list("Pred", "Prey", "Switch", "Non-Vore", "Unset"))
GLOBAL_LIST_INIT(char_directory_erptags, list("Top", "Bottom", "Switch", "No ERP", "Unset"))
=======
GLOBAL_LIST_EMPTY(crafting_recipes) //list of all table craft recipes
>>>>>>> 26f17d2... Merge pull request #8060 from ShadowLarkens/personal_crafting
