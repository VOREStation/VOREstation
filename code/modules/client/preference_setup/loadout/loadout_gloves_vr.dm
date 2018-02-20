/datum/gear/gloves/goldring
	display_name = "wedding ring, gold"
	path = /obj/item/clothing/gloves/weddingring

/datum/gear/gloves/silverring
	display_name = "wedding ring, silver"
	path = /obj/item/clothing/gloves/weddingring/silver

/datum/gear/gloves/colored
	display_name = "gloves, colorable"
	path = /obj/item/clothing/gloves/color

/datum/gear/gloves/colored/New()
	..()
	gear_tweaks = list(gear_tweak_free_color_choice)


/datum/gear/gloves/latex/colorable
	display_name = "gloves, latex, colorable"
	path = /obj/item/clothing/gloves/sterile/latex

/datum/gear/gloves/latex/colorable/New()
	..()
	gear_tweaks = list(gear_tweak_free_color_choice)

/datum/gear/gloves/siren
	display_name = "Siren gloves"
	path = /obj/item/clothing/gloves/fluff/siren