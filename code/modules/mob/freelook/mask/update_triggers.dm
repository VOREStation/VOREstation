//UPDATE TRIGGERS, when the chunk (and the surrounding chunks) should update.

#define CULT_UPDATE_BUFFER 30

/mob/living/var/updating_cult_vision = 0

/mob/living/Moved(atom/old_loc, direction, forced = FALSE)
	. = ..()
	if(!GLOB.cultnet.provides_vision(src))
		return
	if(!updating_cult_vision)
		updating_cult_vision = 1
		spawn(CULT_UPDATE_BUFFER)
			if(old_loc != src.loc)
				GLOB.cultnet.updateVisibility(old_loc, 0)
				GLOB.cultnet.updateVisibility(loc, 0)
			updating_cult_vision = 0

#undef CULT_UPDATE_BUFFER

/mob/living/New()
	..()
	GLOB.cultnet.updateVisibility(src, 0)

/mob/living/Destroy()
	GLOB.cultnet.updateVisibility(src, 0)
	return ..()

/mob/living/rejuvenate()
	var/was_dead = stat == DEAD
	..()
	if(was_dead && stat != DEAD)
		// Arise!
		GLOB.cultnet.updateVisibility(src, 0)

/mob/living/death(gibbed, deathmessage="seizes up and falls limp...")
	if(..(gibbed, deathmessage))
		// If true, the mob went from living to dead (assuming everyone has been overriding as they should...)
		GLOB.cultnet.updateVisibility(src)

/datum/antagonist/add_antagonist(var/datum/mind/player)
	. = ..()
	if(src == GLOB.cult)
		GLOB.cultnet.updateVisibility(player.current, 0)

/datum/antagonist/remove_antagonist(var/datum/mind/player, var/show_message, var/implanted)
	..()
	if(src == GLOB.cult)
		GLOB.cultnet.updateVisibility(player.current, 0)
