// Mask
/datum/gear/mask
	display_name = "bandana, blue"
	path = /obj/item/clothing/mask/bandana/blue
	slot = slot_wear_mask
	sort_category = "Masks and Facewear"

/datum/gear/mask/gold
	display_name = "bandana, gold"
	path = /obj/item/clothing/mask/bandana/gold

/datum/gear/mask/green
	display_name = "bandana, green 2"
	path = /obj/item/clothing/mask/bandana/green

/datum/gear/mask/red
	display_name = "bandana, red"
	path = /obj/item/clothing/mask/bandana/red

/datum/gear/mask/sterile
	display_name = "sterile mask"
	path = /obj/item/clothing/mask/surgical
	cost = 2

/datum/gear/mask/veil
	display_name = "black veil"
	path = /obj/item/clothing/mask/veil

/datum/gear/mask/plaguedoctor2
	display_name = "golden plague doctor's mask"
	path = /obj/item/clothing/mask/gas/plaguedoctor/gold
	cost = 3 ///Because it functions as a gas mask, and therefore has a mechanical advantage.

/datum/gear/mask/gaiter
	display_name = "neck gaiter selection"
	path = /obj/item/clothing/mask/gaiter
	cost = 1

/datum/gear/mask/gaiter/New()
	..()
	var/list/gaiters = list()
	for(var/gaiter in typesof(/obj/item/clothing/mask/gaiter))
		var/obj/item/clothing/mask/gaiter_type = gaiter
		gaiters[initial(gaiter_type.name)] = gaiter_type
	gear_tweaks += new/datum/gear_tweak/path(sortTim(gaiters, /proc/cmp_text_asc))
