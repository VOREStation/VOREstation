// Belt mob spawners
/obj/tether_away_spawner/belt_normal
	name = "Belt Normal Spawner"
	faction = "belter"
	atmos_comp = TRUE
	prob_spawn = 100
	prob_fall = 50
	//guard = 20
	mobs_to_pick_from = list(
		/mob/living/simple_mob/animal/giant_spider/hunter = 1,
		/mob/living/simple_mob/animal/giant_spider/phorogenic/weak = 1,
		/mob/living/simple_mob/animal/giant_spider/tunneler = 1,
	)

/obj/tether_away_spawner/belt_hard
	name = "Belt Hard Spawner"
	faction = "belter"
	atmos_comp = TRUE
	prob_spawn = 100
	prob_fall = 50
	//guard = 20
	mobs_to_pick_from = list(
		/mob/living/simple_mob/vore/aggressive/corrupthound = 1,
		/mob/living/simple_mob/vore/aggressive/rat/phoron = 2
	)

/obj/tether_away_spawner/belt_boss
	name = "Belt Boss Spawner"
	faction = "belter"
	atmos_comp = TRUE
	prob_spawn = 100
	prob_fall = 100
	//guard = 70
	mobs_to_pick_from = list(
		/mob/living/simple_mob/vore/aggressive/dragon = 1
	)

/obj/random/asteroid_belt
	name = "random asteroid belt loot"
	desc = "Random loot for Belt Miners."
	icon = 'icons/obj/items.dmi'
	icon_state = "spickaxe"

/obj/random/underdark/item_to_spawn()
	return pick(prob(3);/obj/random/multiple/underdark/miningdrills,
				prob(3);/obj/random/multiple/underdark/ores,
				prob(2);/obj/random/multiple/underdark/treasure,
				prob(1);/obj/random/multiple/underdark/mechtool)

/obj/random/underdark/uncertain
	icon_state = "upickaxe"
	spawn_nothing_percentage = 65	//only 33% to spawn loot

/obj/random/multiple/underdark/miningdrills
	name = "random underdark mining tool loot"
	desc = "Random mining tool loot for Underdark."
	icon = 'icons/obj/items.dmi'
	icon_state = "spickaxe"

/obj/random/multiple/underdark/miningdrills/item_to_spawn()
	return pick(
				prob(10);list(/obj/item/weapon/pickaxe/silver),
				prob(8);list(/obj/item/weapon/pickaxe/drill),
				prob(6);list(/obj/item/weapon/pickaxe/jackhammer),
				prob(5);list(/obj/item/weapon/pickaxe/gold),
				prob(4);list(/obj/item/weapon/pickaxe/plasmacutter),
				prob(2);list(/obj/item/weapon/pickaxe/diamond),
				prob(1);list(/obj/item/weapon/pickaxe/diamonddrill)
				)

/obj/random/multiple/underdark/ores
	name = "random underdark mining ore loot"
	desc = "Random mining utility loot for Underdark."
	icon = 'icons/obj/mining.dmi'
	icon_state = "satchel"

/obj/random/multiple/underdark/ores/item_to_spawn()
	return pick(
				prob(9);list(
							/obj/item/weapon/storage/bag/ore,
							/obj/item/weapon/shovel,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/glass,
							/obj/item/weapon/ore/hydrogen,
							/obj/item/weapon/ore/hydrogen,
							/obj/item/weapon/ore/hydrogen,
							/obj/item/weapon/ore/hydrogen,
							/obj/item/weapon/ore/hydrogen,
							/obj/item/weapon/ore/hydrogen
							),
				prob(7);list(
							/obj/item/weapon/storage/bag/ore,
							/obj/item/weapon/pickaxe,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium,
							/obj/item/weapon/ore/osmium
							),
				prob(4);list(
							/obj/item/clothing/suit/radiation,
							/obj/item/clothing/head/radiation,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium,
							/obj/item/weapon/ore/uranium),
				prob(2);list(
							/obj/item/device/flashlight/lantern,
							/obj/item/clothing/glasses/material,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond,
							/obj/item/weapon/ore/diamond
							),
				prob(1);list(
							/obj/item/weapon/mining_scanner,
							/obj/item/weapon/shovel/spade,
							/obj/item/weapon/ore/verdantium,
							/obj/item/weapon/ore/verdantium,
							/obj/item/weapon/ore/verdantium,
							/obj/item/weapon/ore/verdantium,
							/obj/item/weapon/ore/verdantium
							)
				)

/obj/random/multiple/underdark/treasure
	name = "random underdark treasure"
	desc = "Random treasure loot for Underdark."
	icon = 'icons/obj/storage.dmi'
	icon_state = "cashbag"

/obj/random/multiple/underdark/treasure/item_to_spawn()
	return pick(
				prob(5);list(
							/obj/random/coin,
							/obj/random/coin,
							/obj/random/coin,
							/obj/random/coin,
							/obj/random/coin,
							/obj/item/clothing/head/pirate
							),
				prob(4);list(
							/obj/item/weapon/storage/bag/cash,
							/obj/item/weapon/spacecash/c500,
							/obj/item/weapon/spacecash/c100,
							/obj/item/weapon/spacecash/c50
							),
				prob(3);list(
							/obj/item/clothing/head/hardhat/orange,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold,
							/obj/item/stack/material/gold),
				prob(1);list(
							/obj/item/stack/material/phoron,
							/obj/item/stack/material/phoron,
							/obj/item/stack/material/phoron,
							/obj/item/stack/material/phoron,
							/obj/item/stack/material/diamond,
							/obj/item/stack/material/diamond,
							/obj/item/stack/material/diamond
							)
				)

/obj/random/multiple/underdark/mechtool
	name = "random underdark mech equipment"
	desc = "Random mech equipment loot for Underdark."
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_clamp"

/obj/random/multiple/underdark/mechtool/item_to_spawn()
	return pick(
				prob(12);list(/obj/item/mecha_parts/mecha_equipment/tool/drill),
				prob(10);list(/obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp),
				prob(8);list(/obj/item/mecha_parts/mecha_equipment/generator),
				prob(7);list(/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot/rigged),
				prob(6);list(/obj/item/mecha_parts/mecha_equipment/repair_droid),
				prob(3);list(/obj/item/mecha_parts/mecha_equipment/gravcatapult),
				prob(2);list(/obj/item/mecha_parts/mecha_equipment/weapon/energy/riggedlaser),
				prob(2);list(/obj/item/mecha_parts/mecha_equipment/weapon/energy/flamer/rigged),
				prob(1);list(/obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill),
				)

//POI STUFF
VIRGO3B_TURF_CREATE(/turf/simulated/mineral/ignore_oregen)
VIRGO3B_TURF_CREATE(/turf/simulated/mineral/floor/ignore_oregen)
VIRGO3B_TURF_CREATE(/turf/simulated/mineral/ignore_cavegen)
VIRGO3B_TURF_CREATE(/turf/simulated/mineral/floor/ignore_cavegen)

//Vault2
VIRGO3B_TURF_CREATE(/turf/simulated/floor/tiled/freezer)

//Abandonedshelter
VIRGO3B_TURF_CREATE(/turf/simulated/shuttle/floor/voidcraft)

//Goldhall
VIRGO3B_TURF_CREATE(/turf/simulated/floor/tiled/kafel_full/yellow)

//Mechbay
/obj/mecha/working/ripley/abandoned/Initialize()
	..()
	for(var/obj/item/mecha_parts/mecha_tracking/B in src.contents)	//Deletes the beacon so it can't be found easily
		qdel(B)