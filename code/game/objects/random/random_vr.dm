/obj/random/weapon // For Gateway maps and Syndicate. Can possibly spawn almost any gun in the game.
	name = "Random Illegal Weapon"
	desc = "This is a random illegal weapon."
	icon = 'icons/obj/gun.dmi'
	icon_state = "p08"
	spawn_nothing_percentage = 50
	item_to_spawn()
		return pick(prob(11);/obj/random/ammo_all,\
					prob(11);/obj/item/weapon/gun/energy/laser,\
					prob(11);/obj/item/weapon/gun/projectile/pirate,\
					prob(10);/obj/item/weapon/material/twohanded/spear,\
					prob(10);/obj/item/weapon/gun/energy/stunrevolver,\
					prob(10);/obj/item/weapon/gun/energy/taser,\
					prob(10);/obj/item/weapon/gun/launcher/crossbow,\
					prob(10);/obj/item/weapon/gun/projectile/shotgun/doublebarrel/pellet,\
					prob(10);/obj/item/weapon/material/knife,\
					prob(10);/obj/item/weapon/material/hatchet/tacknife/combatknife,\
					prob(10);/obj/item/weapon/material/butterfly/switchblade,\
					prob(10);/obj/item/weapon/gun/projectile/luger,\
					prob(10);/obj/item/weapon/gun/projectile/luger/brown,\
				/*	prob(10);/obj/item/weapon/gun/projectile/pipegun,\ */
					prob(10);/obj/item/weapon/gun/projectile/revolver,\
					prob(10);/obj/item/weapon/gun/projectile/revolver/detective,\
					prob(10);/obj/item/weapon/gun/projectile/revolver/mateba,\
					prob(10);/obj/item/weapon/gun/projectile/revolver/judge,\
					prob(10);/obj/item/weapon/gun/projectile/colt,\
					prob(10);/obj/item/weapon/gun/projectile/shotgun/pump,\
					prob(10);/obj/item/weapon/gun/projectile/shotgun/pump/rifle,\
					prob(10);/obj/item/weapon/gun/projectile/shotgun/pump/rifle/mosin,\
					prob(10);/obj/item/weapon/melee/baton,\
					prob(10);/obj/item/weapon/melee/telebaton,\
					prob(10);/obj/item/weapon/melee/classic_baton,\
					prob(10);/obj/item/weapon/melee/energy/sword,\
					prob(9);/obj/item/weapon/gun/projectile/automatic/wt550/lethal,\
					prob(9);/obj/item/weapon/gun/projectile/automatic/pdw,\
					prob(9);/obj/item/weapon/gun/projectile/automatic/SMG_sol, \
					prob(9);/obj/item/weapon/gun/energy/crossbow/largecrossbow,\
					prob(9);/obj/item/weapon/gun/projectile/automatic/mini_uzi,\
					prob(9);/obj/item/weapon/gun/projectile/pistol,\
					prob(9);/obj/item/weapon/gun/projectile/shotgun/pump/combat,\
					prob(9);/obj/item/weapon/twohanded/fireaxe,\
					prob(9);/obj/item/weapon/cane/concealed,\
					prob(9);/obj/item/weapon/gun/energy/gun,\
					prob(8);/obj/item/weapon/gun/energy/retro,\
					prob(8);/obj/item/weapon/gun/energy/gun/eluger,\
					prob(8);/obj/item/weapon/gun/energy/xray,\
					prob(8);/obj/item/weapon/gun/projectile/automatic/c20r,\
					prob(8);/obj/item/weapon/gun/projectile/automatic/stg,\
					prob(8);/obj/item/weapon/melee/energy/sword,\
					prob(8);/obj/item/weapon/gun/projectile/derringer,\
					prob(8);/obj/item/weapon/gun/projectile/revolver/lemat,\
				/*	prob(8);/obj/item/weapon/gun/projectile/automatic/m41a,\ */
					prob(7);/obj/item/weapon/gun/energy/captain,\
					prob(7);/obj/item/weapon/gun/energy/sniperrifle,\
					prob(7);/obj/item/weapon/gun/projectile/automatic/p90,\
					prob(7);/obj/item/weapon/gun/projectile/automatic/as24,\
					prob(7);/obj/item/weapon/gun/projectile/automatic/sts35,\
					prob(7);/obj/item/weapon/gun/projectile/automatic/z8,\
					prob(7);/obj/item/weapon/gun/energy/gun/burst,\
					prob(7);/obj/item/weapon/gun/projectile/shotgun/pump/unsc,\
					prob(7);/obj/item/weapon/gun/projectile/deagle,\
					prob(7);/obj/item/weapon/gun/projectile/revolver/consul,\
					prob(7);/obj/item/weapon/gun/launcher/grenade,\
					prob(6);/obj/item/weapon/gun/projectile/SVD,\
					prob(6);/obj/item/weapon/gun/projectile/automatic/l6_saw,\
					prob(6);/obj/item/weapon/gun/energy/lasercannon,\
					prob(5);/obj/item/weapon/gun/projectile/shotgun/pump/rifle/lever,\
					prob(5);/obj/item/weapon/gun/projectile/automatic/carbine,\
					prob(5);/obj/item/weapon/gun/energy/pulse_rifle,\
				/*	prob(4);/obj/item/weapon/gun/projectile/automatic/battlerifle,\ */
					prob(3);/obj/item/weapon/gun/projectile/deagle/camo,\
					prob(3);/obj/item/weapon/gun/energy/gun/nuclear,\
					prob(2);/obj/item/weapon/gun/projectile/deagle/gold,\
					prob(1);/obj/item/weapon/gun/launcher/rocket,\
					prob(1);/obj/item/weapon/gun/launcher/grenade,\
					prob(1);/obj/item/weapon/gun/projectile/gyropistol,\
					prob(1);/obj/item/weapon/gun/projectile/heavysniper,\
					prob(1);/obj/item/weapon/plastique,\
					prob(1);/obj/item/weapon/gun/energy/ionrifle,\
					prob(1);/obj/item/weapon/material/sword,\
					prob(1);/obj/item/weapon/cane/concealed,\
					prob(1);/obj/item/weapon/material/sword/katana)

/obj/random/weapon/guarenteed
	spawn_nothing_percentage = 0

/obj/random/ammo_all
	name = "Random Ammunition (All)"
	desc = "This is random ammunition. Spawns all ammo types."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "666"
	item_to_spawn()
		return pick(prob(5);/obj/item/weapon/storage/box/shotgunammo,\
					prob(5);/obj/item/weapon/storage/box/shotgunshells,\
					prob(5);/obj/item/ammo_magazine/s357,\
					prob(5);/obj/item/ammo_magazine/clip/c762,\
					prob(5);/obj/item/ammo_magazine/m45,\
					prob(5);/obj/item/ammo_magazine/m45/rubber,\
					prob(5);/obj/item/ammo_magazine/s38,\
					prob(5);/obj/item/ammo_magazine/s38/rubber,\
					prob(5);/obj/item/weapon/storage/box/flashbangs,\
					prob(5);/obj/item/ammo_magazine/m556,\
					prob(4);/obj/item/ammo_magazine/clip/c556,\
					prob(4);/obj/item/ammo_magazine/clip/c45,\
					prob(4);/obj/item/ammo_magazine/clip/c9mm,\
					prob(4);/obj/item/ammo_magazine/m45uzi,\
					prob(4);/obj/item/ammo_magazine/m556/ext,\
					prob(4);/obj/item/ammo_magazine/m9mm,\
					prob(4);/obj/item/ammo_magazine/m9mml,\
					prob(4);/obj/item/ammo_magazine/m9mmt,\
					prob(4);/obj/item/ammo_magazine/m9mmt/rubber,\
					prob(4);/obj/item/ammo_magazine/m10mm,\
					prob(4);/obj/item/ammo_magazine/m9mmp90,\
				/*	prob(4);/obj/item/ammo_magazine/m14,\
					prob(4);/obj/item/ammo_magazine/m14/large,\ */
					prob(4);/obj/item/ammo_magazine/m556/ext,\
					prob(4);/obj/item/ammo_magazine/m762,\
					prob(4);/obj/item/ammo_magazine/m762,\
					prob(3);/obj/item/ammo_magazine/clip/c10mm,\
					prob(3);/obj/item/ammo_magazine/clip/c44,\
					prob(3);/obj/item/ammo_magazine/s44,\
					prob(3);/obj/item/ammo_magazine/m556,\
					prob(2);/obj/item/ammo_magazine/m44,\
					prob(2);/obj/item/ammo_magazine/m556,\
					prob(1);/obj/item/weapon/storage/box/frags,\
				/*	prob(1);/obj/item/ammo_magazine/battlerifle,\ */
					prob(1);/obj/item/ammo_casing/rocket,\
					prob(1);/obj/item/weapon/storage/box/sniperammo,\
					prob(1);/obj/item/weapon/storage/box/flashshells,\
					prob(1);/obj/item/weapon/storage/box/beanbags,\
					prob(1);/obj/item/weapon/storage/box/practiceshells,\
					prob(1);/obj/item/weapon/storage/box/stunshells,\
					prob(1);/obj/item/weapon/storage/box/blanks,\
					prob(1);/obj/item/ammo_magazine/mtg,\
					prob(1);/obj/item/ammo_magazine/m45tommydrum,\
					prob(1);/obj/item/ammo_magazine/m45tommy
					)

/obj/random/cargopod
	name = "Random Cargo Item"
	desc = "Hot Stuff."
	icon = 'icons/obj/items.dmi'
	icon_state = "purplecomb"
	spawn_nothing_percentage = 0
/obj/random/cargopod/item_to_spawn()
	return pick(prob(6);/obj/item/weapon/storage/pill_bottle/tramadol,
				prob(8);/obj/item/weapon/haircomb,
				prob(4);/obj/item/weapon/storage/pill_bottle/happy,
				prob(4);/obj/item/weapon/storage/pill_bottle/zoom,
				prob(10);/obj/item/weapon/contraband/poster,
				prob(4);/obj/item/weapon/material/butterfly,
				prob(6);/obj/item/weapon/material/butterflyblade,
				prob(6);/obj/item/weapon/material/butterflyhandle,
				prob(6);/obj/item/weapon/material/wirerod,
				prob(2);/obj/item/weapon/material/butterfly/switchblade,
				prob(2);/obj/item/weapon/material/knuckledusters,
				prob(1);/obj/item/weapon/material/hatchet/tacknife,
				prob(1);/obj/item/clothing/suit/storage/vest/heavy/merc,
				prob(1);/obj/item/weapon/beartrap,
				prob(1);/obj/item/weapon/handcuffs,
				prob(1);/obj/item/weapon/legcuffs,
				prob(2);/obj/item/weapon/reagent_containers/syringe/drugs,
				prob(1);/obj/item/weapon/reagent_containers/syringe/steroid)

//A random thing so that the spawn_nothing_percentage can be used w/o duplicating code.
/obj/random/trash_pile
	name = "Random Trash Pile"
	desc = "Hot Garbage."
	icon = 'icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	spawn_nothing_percentage = 0
/obj/random/trash_pile/item_to_spawn()
	return	/obj/structure/trash_pile

/obj/random/outside_mob
	name = "Random Mob"
	desc = "Eek!"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	spawn_nothing_percentage = 10
	var/faction = "wild animal"

/obj/random/outside_mob/item_to_spawn() // Special version for mobs to have the same faction.
	var/mob = pick(prob(10);/mob/living/simple_animal/hostile/scarybat,
				prob(10);/mob/living/simple_animal/retaliate/gaslamp,
				prob(10);/mob/living/simple_animal/otie/feral,
				prob(5);/mob/living/simple_animal/hostile/dino,
				prob(1);/mob/living/simple_animal/hostile/bear,
				prob(1);/mob/living/simple_animal/hostile/dragon)
	if (istype(mob, /mob/living)) // This is just to prevent runtime errors in case some dev is a dumbass and puts invalid items into this.
		var/mob/living/simple_animal/this_mob = mob
		this_mob.faction = faction
		if (this_mob.minbodytemp > 200) // Temporary hotfix. Eventually I'll add code to change all mob vars to fit the environment they are spawned in.
			this_mob.minbodytemp = 200
		return this_mob
	else
		return mob

/obj/random/outside_mob/spawn_item()
	..()
	var/datum/map_z_level/z_level = get_z_level_datum(spawned_thing)
	if(!istype(z_level, /datum/map_z_level/tether/wilderness))
		return
	if(!istype(spawned_thing, /mob/living/simple_animal))
		return
	var/datum/map_z_level/tether/wilderness/wilderness = z_level
	var/mob/living/simple_animal/M = spawned_thing
	wilderness.frozen_mobs += M
	M.life_disabled = 1
	for(var/i = 1 to 20) //wander the mobs around so they aren't always in the same spots
		step_rand(M)
		sleep(2)