/datum/artifact_effect/gasphoron
	name = "phoron creation"

	effect_color = "#c408ba"

/datum/artifact_effect/gasphoron/New()
	..()
	effect = pick(EFFECT_TOUCH, EFFECT_AURA)
	effect_type = EFFECT_GAS_PHORON

/datum/artifact_effect/gasphoron/DoEffectTouch(var/mob/user)
	var/atom/holder = get_master_holder()
	if(holder)
		var/turf/holder_loc = holder.loc
		if(istype(holder_loc))
			holder_loc.assume_gas(GAS_PHORON, rand(2, 15))

/datum/artifact_effect/gasphoron/DoEffectAura()
	var/atom/holder = get_master_holder()
	if(holder)
		var/turf/holder_loc = holder.loc
		if(istype(holder_loc))
			holder_loc.assume_gas(GAS_PHORON, pick(0, 0, 0.1, rand()))
