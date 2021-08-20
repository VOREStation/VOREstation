// ported from Citadel-Station-13/Citadel-Station-13-RP#3015, basically all the work done by silicons
// thanks silicons

/*********************Mining Hammer****************/
/obj/item/weapon/kinetic_crusher
	icon = 'icons/obj/mining_vr.dmi'
	icon_state = "crusher"
	item_state = "crusher0"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_melee_vr.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_melee_vr.dmi'
		)
	name = "proto-kinetic crusher"
	desc = "An early design of the proto-kinetic accelerator, it is little more than an combination of various mining tools cobbled together, forming a high-tech club. \
	While it is an effective mining tool, it did little to aid any but the most skilled and/or suicidal miners against local fauna."
	force = 0 //You can't hit stuff unless wielded
	w_class = ITEMSIZE_LARGE
	slot_flags = SLOT_BACK
	throwforce = 5
	throw_speed = 4
/*
	armour_penetration = 10
	custom_materials = list(/datum/material/iron=1150, /datum/material/glass=2075)
*/
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("smashed", "crushed", "cleaved", "chopped", "pulped")
	sharp = TRUE
	edge = TRUE
	// sharpness = SHARP_EDGED
	action_button_name = "Toggle Light"
	// actions_types = list(/datum/action/item_action/toggle_light)
	// var/list/trophies = list()
	var/charged = TRUE
	var/charge_time = 15
	var/detonation_damage = 50
	var/backstab_bonus = 30
	var/integ_light_on = FALSE
	var/brightness_on = 7
	var/wielded = FALSE // track wielded status on item
	/// is this emagged? (unlocks !!!FUN!!!)
	var/emagged = 0
	/// Damage penalty factor to detonation damage to non simple mobs
	var/human_damage_nerf = 0.25
	/// Damage penalty factor to backstab bonus damage to non simple mobs
	var/human_backstab_nerf = 0.25
	/// damage buff for throw impacts
	var/thrown_bonus = 35
	/// do we need to be wielded?
	var/requires_wield = TRUE
	/// do we have a charge overlay?
	var/charge_overlay = TRUE
	/// do we update item state?
	var/update_item_state = FALSE

/obj/item/weapon/kinetic_crusher/cyborg //probably give this a unique sprite later
	desc = "An integrated version of the standard kinetic crusher with a grinded down axe head to dissuade mis-use against crewmen. Deals damage equal to the standard crusher against creatures, however."
	force = 10 //wouldn't want to give a borg a 20 brute melee weapon unemagged now would we
	detonation_damage = 60
	wielded = 1

/obj/item/weapon/kinetic_crusher/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/conflict_checking, CONFLICT_ELEMENT_CRUSHER)

/*
/obj/item/weapon/kinetic_crusher/Initialize()
	. = ..()
	if(requires_Wield)
		RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
		RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/weapon/kinetic_crusher/ComponentInitialize()
	. = ..()
	if(requires_wield)
		AddComponent(/datum/component/butchering, 60, 110) //technically it's huge and bulky, but this provides an incentive to use it
		AddComponent(/datum/component/two_handed, force_unwielded=0, force_wielded=20)
*/

/obj/item/weapon/kinetic_crusher/Destroy()
	// QDEL_LIST(trophies)
	return ..()

/obj/item/weapon/kinetic_crusher/emag_act()
	. = ..()
	if(emagged)
		return
	emagged = TRUE

/obj/item/weapon/kinetic_crusher/proc/can_mark(mob/living/victim)
	if(emagged)
		return TRUE
	return !ishuman(victim) && !issilicon(victim)

/// triggered on wield of two handed item
/obj/item/weapon/kinetic_crusher/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/weapon/kinetic_crusher/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE

/obj/item/weapon/kinetic_crusher/examine(mob/living/user)
	. = ..()
	. += "<span class='notice'>Mark a large creature with the destabilizing force, then hit them in melee to do <b>[force + detonation_damage]</b> damage.</span>"
	. += "<span class='notice'>Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.</span>"
/*
	for(var/t in trophies)
		var/obj/item/crusher_trophy/T = t
		. += "<span class='notice'>It has \a [T] attached, which causes [T.effect_desc()].</span>"
*/

/*
/obj/item/weapon/kinetic_crusher/attackby(obj/item/I, mob/living/user)
	if(I.tool_behaviour == TOOL_CROWBAR)
		if(LAZYLEN(trophies))
			to_chat(user, "<span class='notice'>You remove [src]'s trophies.</span>")
			I.play_tool_sound(src)
			for(var/t in trophies)
				var/obj/item/crusher_trophy/T = t
				T.remove_from(src, user)
		else
			to_chat(user, "<span class='warning'>There are no trophies on [src].</span>")
	else if(istype(I, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = I
		T.add_to(src, user)
	else
		return ..()
*/

/obj/item/weapon/kinetic_crusher/attack(mob/living/target, mob/living/carbon/user)
	if(!wielded && requires_wield)
		to_chat(user, "<span class='warning'>[src] is too heavy to use with one hand.")
		return
	var/datum/status_effect/crusher_damage/C = target.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = target.health
	..()
/*
	for(var/t in trophies)
		if(!QDELETED(target))
			var/obj/item/crusher_trophy/T = t
			T.on_melee_hit(target, user)
*/
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health //we did some damage, but let's not assume how much we did

/obj/item/weapon/kinetic_crusher/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
/*
	if(istype(target, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = target
		T.add_to(src, user)
*/
	if(requires_wield && !wielded)
		return
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/item/projectile/destabilizer/D = new /obj/item/projectile/destabilizer(proj_turf)
/*
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
*/
		D.preparePixelProjectile(target, user, clickparams)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, 1)
		D.fire()
		charged = FALSE
		update_icon()
		addtimer(CALLBACK(src, .proc/Recharge), charge_time * (user?.ConflictElementCount(CONFLICT_ELEMENT_CRUSHER) || 1))
		return
	if(proximity_flag && isliving(target))
		detonate(target, user)

/obj/item/weapon/kinetic_crusher/proc/detonate(mob/living/L, mob/living/user, thrown = FALSE)
	var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)
	if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK))
		return
	var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = L.health
/*
	for(var/t in trophies)
		var/obj/item/crusher_trophy/T = t
		T.on_mark_detonation(target, user)
*/
	if(!QDELETED(L))
		if(!QDELETED(C))
			C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
		new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
		var/backstab_dir = get_dir(user, L)
		var/def_check = L.getarmor(type = "bomb")
		var/detonation_damage = src.detonation_damage * (!ishuman(L)? 1 : human_damage_nerf)
		var/backstab_bonus = src.backstab_bonus * (!ishuman(L)? 1 : human_backstab_nerf)
		var/thrown_bonus = thrown? (src.thrown_bonus * (!ishuman(L)? 1 : human_damage_nerf)) : 0
		if(thrown? (get_dir(src, L) & L.dir) : ((user.dir & backstab_dir) && (L.dir & backstab_dir)))
			if(!QDELETED(C))
				C.total_damage += detonation_damage + backstab_bonus + thrown_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
			L.apply_damage(detonation_damage + backstab_bonus + thrown_bonus, BRUTE, blocked = def_check)
			playsound(src, 'sound/weapons/Kenetic_accel.ogg', 100, 1) //Seriously who spelled it wrong
		else
			if(!QDELETED(C))
				C.total_damage += detonation_damage + thrown_bonus
			L.apply_damage(detonation_damage + thrown_bonus, BRUTE, blocked = def_check)

/obj/item/weapon/kinetic_crusher/throw_impact(atom/hit_atom, speed)
	. = ..()
	if(!isliving(hit_atom))
		return
	var/mob/living/L = hit_atom
	if(!L.has_status_effect(STATUS_EFFECT_CRUSHERMARK))
		detonate(L, thrower, TRUE)

/obj/item/weapon/kinetic_crusher/proc/Recharge()
	if(!charged)
		charged = TRUE
		update_icon()
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, 1)

/obj/item/weapon/kinetic_crusher/ui_action_click(mob/user, actiontype)
	integ_light_on = !integ_light_on
	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	update_brightness(user)
	update_icon()

/obj/item/weapon/kinetic_crusher/proc/update_brightness(mob/user = null)
	if(integ_light_on)
		set_light(brightness_on)
	else
		set_light(0)

/obj/item/weapon/kinetic_crusher/update_icon_state()
	if(update_item_state)
		item_state = "crusher[wielded]" // this is not icon_state and not supported by 2hcomponent

/obj/item/weapon/kinetic_crusher/update_overlays()
	. = ..()
	if(!charged && charge_overlay)
		. += "[icon_state]_uncharged"
	if(integ_light_on)
		. += "[icon_state]_lit"

/*
/obj/item/weapon/kinetic_crusher/glaive
	name = "proto-kinetic glaive"
	desc = "A modified design of a proto-kinetic crusher, it is still little more of a combination of various mining tools cobbled together \
	and kit-bashed into a high-tech cleaver on a stick - with a handguard and a goliath hide grip. While it is still of little use to any \
	but the most skilled and/or suicidal miners against local fauna, it's an elegant weapon for a more civilized hunter."
    
    look gary there i am
    - hatterhat
*/

/obj/item/weapon/kinetic_crusher/machete
	name = "proto-kinetic machete"
	desc = "A scaled down version of a proto-kinetic crusher, used by people who don't want to lug around an axe-hammer."
	icon_state = "glaive-machete"
	item_icons = list(
			slot_l_hand_str = 'icons/mob/items/lefthand_melee_vr.dmi',
			slot_r_hand_str = 'icons/mob/items/righthand_melee_vr.dmi',
			)
	item_state = "g-machete"
	w_class = ITEMSIZE_SMALL
	force = 24
	can_cleave = TRUE
	requires_wield = FALSE
	// yeah yeah buff but polaris mobs are meatwalls.
	backstab_bonus = 40
	detonation_damage = 26
	// meme option
	thrown_bonus = 20
	update_item_state = FALSE

/obj/item/weapon/kinetic_crusher/machete/dagger
	name = "proto-kinetic dagger"
	desc = "A scaled down version of a proto-kinetic machete, usually used in a last ditch scenario."
	icon_state = "glaive-dagger"
	item_icons = list(
			slot_l_hand_str = 'icons/mob/items/lefthand_melee_vr.dmi',
			slot_r_hand_str = 'icons/mob/items/righthand_melee_vr.dmi',
			)
	item_state = "machete"
	w_class = ITEMSIZE_SMALL
	force = 15
	requires_wield = FALSE
	charge_overlay = FALSE
	backstab_bonus = 35
	detonation_damage = 25
	// woohoo
	thrown_bonus = 35
	update_item_state = FALSE


//destablizing force
/obj/item/projectile/destabilizer
	name = "destabilizing force"
	icon_state = "pulse1"
	nodamage = TRUE
	damage = 0 //We're just here to mark people. This is still a melee weapon.
	damage_type = BRUTE
	check_armour = "bomb"
	range = 6
	accuracy = INFINITY	// NO.
	// log_override = TRUE
	var/obj/item/weapon/kinetic_crusher/hammer_synced

/obj/item/projectile/destabilizer/Destroy()
	hammer_synced = null
	return ..()

/obj/item/projectile/destabilizer/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		L.apply_status_effect(STATUS_EFFECT_CRUSHERMARK, hammer_synced)
		// var/had_effect = (L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)) //used as a boolean
		// var/datum/status_effect/crusher_mark/CM = L.apply_status_effect(STATUS_EFFECT_CRUSHERMARK, hammer_synced)
/*
		if(hammer_synced)
			for(var/t in hammer_synced.trophies)
				var/obj/item/crusher_trophy/T = t
				T.on_mark_application(target, CM, had_effect)
*/
	var/target_turf = get_turf(target)
	if(ismineralturf(target_turf))
		var/turf/simulated/mineral/M = target_turf
		new /obj/effect/temp_visual/kinetic_blast(M)
		M.GetDrilled(firer)
	..()

/*
//trophies

there would be any if we had some
but alas
- hatterhat
*/

