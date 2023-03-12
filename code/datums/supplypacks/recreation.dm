/*
 *	Here is where any supply packs
 *	related to recreation live.
 */


/datum/supply_pack/recreation
	group = "Recreation"

/datum/supply_pack/randomised/recreation
	group = "Recreation"
	access = access_security

/datum/supply_pack/recreation/foam_weapons
	name = "Foam Weapon Crate"
	contains = list(
			/obj/item/weapon/material/sword/foam = 2,
			/obj/item/weapon/material/twohanded/baseballbat/foam = 2,
			/obj/item/weapon/material/twohanded/spear/foam = 2,
			/obj/item/weapon/material/twohanded/fireaxe/foam = 2
			)
	cost = 50
	containertype = /obj/structure/closet/crate/allico
	containername = "foam weapon crate"

/datum/supply_pack/recreation/donksoftweapons
	name = "Donk-Soft Weapon Crate"
	contains = list(
			/obj/item/ammo_magazine/ammo_box/foam = 2,
			/obj/item/weapon/gun/projectile/shotgun/pump/toy = 2,
			/obj/item/weapon/gun/projectile/pistol/toy = 2,
			/obj/item/ammo_magazine/mfoam_dart/pistol = 2
			)
	cost = 50
	containertype = /obj/structure/closet/crate/allico
	containername = "foam weapon crate"

/datum/supply_pack/recreation/donksoftborg
	name = "Donk-Soft Cyborg Blaster Crate"
	contains = list(
			/obj/item/borg/upgrade/toygun = 2,
			)
	cost = 35
	containertype = /obj/structure/closet/crate/allico
	containername = "foam weapon crate"

/datum/supply_pack/recreation/donksoftvend
	name = "Donk-Soft Vendor Crate"
	contains = list()
	cost = 75
	containertype = /obj/structure/largecrate/donksoftvendor
	containername = "\improper Donk-Soft vendor crate"

/datum/supply_pack/recreation/lasertag
	name = "Lasertag equipment"
	contains = list(
			/obj/item/weapon/gun/energy/lasertag/red,
			/obj/item/clothing/suit/redtag,
			/obj/item/weapon/gun/energy/lasertag/blue,
			/obj/item/clothing/suit/bluetag
			)
	containertype = /obj/structure/closet/crate/ward
	containername = "Lasertag Supplies"
	cost = 10

/datum/supply_pack/recreation/artscrafts
	name = "Arts and Crafts supplies"
	contains = list(
			/obj/item/weapon/storage/fancy/crayons,
			/obj/item/weapon/storage/fancy/markers,
			/obj/item/device/camera,
			/obj/item/device/camera_film = 2,
			/obj/item/weapon/storage/photo_album,
			/obj/item/weapon/packageWrap,
			/obj/item/poster/custom,
			/obj/item/weapon/wrapping_paper = 3,
			/obj/structure/easel,
			/obj/item/paint_brush,
			/obj/item/paint_palette,
			/obj/item/canvas = 3,
			/obj/item/canvas/nineteen_nineteen = 2,
			/obj/item/canvas/twentythree_nineteen = 2,
			/obj/item/canvas/twentythree_twentythree = 2,
			/obj/item/canvas/twentyfour_twentyfour = 2
			)
	cost = 10
	containertype = /obj/structure/closet/crate/allico
	containername = "Arts and Crafts crate"

/datum/supply_pack/recreation/painters
	name = "Station Painting Supplies"
	cost = 10
	containername = "station painting supplies crate"
	containertype = /obj/structure/closet/crate/grayson
	contains = list(
			/obj/item/device/pipe_painter = 2,
			/obj/item/device/floor_painter = 2,
			/obj/item/weapon/reagent_containers/glass/paint/red,
			/obj/item/weapon/reagent_containers/glass/paint/green,
			/obj/item/weapon/reagent_containers/glass/paint/blue,
			/obj/item/weapon/reagent_containers/glass/paint/yellow,
			/obj/item/weapon/reagent_containers/glass/paint/violet,
			/obj/item/weapon/reagent_containers/glass/paint/cyan,
			/obj/item/weapon/reagent_containers/glass/paint/orange,
			/obj/item/weapon/reagent_containers/glass/paint/purple,
			/obj/item/weapon/reagent_containers/glass/paint/grey,
			/obj/item/weapon/reagent_containers/glass/paint/black,
			/obj/item/weapon/reagent_containers/glass/paint/white = 3
			)

/datum/supply_pack/recreation/cheapbait
	name = "Cheap Fishing Bait"
	cost = 10
	containername = "cheap bait crate"
	containertype = /obj/structure/closet/crate/freezer
	contains = list(
			/obj/item/weapon/storage/box/wormcan/sickly = 5
			)

/datum/supply_pack/randomised/recreation/cheapbait
	name = "Deluxe Fishing Bait"
	cost = 40
	containername = "deluxe bait crate"
	containertype = /obj/structure/closet/crate/carp
	num_contained = 8
	contains = list(
			/obj/item/weapon/storage/box/wormcan,
			/obj/item/weapon/storage/box/wormcan/deluxe
			)

/datum/supply_pack/recreation/ltagturrets
	name = "Laser Tag Turrets"
	cost = 40
	containername = "laser tag turret crate"
	containertype = /obj/structure/closet/crate/ward
	contains = list(
			/obj/machinery/porta_turret/lasertag/blue,
			/obj/machinery/porta_turret/lasertag/red
<<<<<<< HEAD
			)
=======
			)

/datum/supply_pack/recreation/card_packs
	contains = list(
			/obj/item/pack/cardemon = 4,
			/obj/item/pack/spaceball = 4,
			/obj/item/deck/cardemon = 2,
			/obj/item/deck/spaceball = 2
			)
	name = "Trading Card Crate"
	cost = 15
	containertype = /obj/structure/closet/crate/oculum
	containername = "cards crate"

/datum/supply_pack/recreation/sas_builder
	contains = list(
			/obj/item/deck/saintsandsins = 2,
			/obj/item/pack/saintsandsins = 2,
			/obj/random/saintsandsins_packs = 2
			)
	name = "Saints and Sins Builder's Crate"
	cost = 40
	containertype = /obj/structure/closet/crate/oculum
	containername = "\improper Saints and Sins builder's crate"

/datum/supply_pack/recreation/sas_booster
	contains = list(
			/obj/random/saintsandsins_packs = 6
			)
	name = "Saints and Sins Booster Crate"
	cost = 20
	containertype = /obj/structure/closet/crate/oculum
	containername = "\improper Saints and Sins booster crate"
>>>>>>> 8918629df18... Adds MtG except in space (#9007)
