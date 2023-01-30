//////////////////////////////////////////////////////
////////////////////SUBTLE COMMAND////////////////////
//////////////////////////////////////////////////////

/mob/verb/me_verb_subtle(message as message) //This would normally go in say.dm
	set name = "Subtle"
	set category = "IC"
	set desc = "Emote to nearby people (and your pred/prey)"

	if(say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "Speech is currently admin-disabled.")
		return
	//VOREStation Addition Start
	if(forced_psay)
		pme(message)
		return
	//VOREStation Addition End

	message = sanitize_or_reflect(message,src) //VOREStation Edit - Reflect too-long messages (within reason)
	if(!message)
		return

	set_typing_indicator(FALSE)
	if(use_me)
		usr.emote_vr("me",4,message)
	else
		usr.emote_vr(message)

/mob/proc/get_all_in_bellies()
	var/list/mobs_in_belly = list()
	for (var/obj/belly/belly in contents) //dogborg sleeper, etc
		for (var/mob/M in belly.contents)
			mobs_in_belly |= M.get_all_in_bellies()
			mobs_in_belly |= M
	return mobs_in_belly

/atom/proc/get_ultimate_mob()
	var/mob/ultimate_mob
	var/atom/to_check = loc
	var/n = 0
	while (to_check && !isturf(to_check) && n < 6)
		if (ismob(to_check))
			ultimate_mob = to_check
			to_check = to_check.loc
			n = 0
		n++
	return ultimate_mob

/atom/proc/get_ultimate_belly()
	var/obj/belly/ultimate_belly
	var/atom/to_check = loc
	var/n = 0
	while (to_check && !isturf(to_check) && n < 6)
		if (isbelly(to_check))
			ultimate_belly = to_check
			to_check = to_check.loc
			n = 0
		n++
	return ultimate_belly

/mob/proc/custom_emote_vr(var/m_type=1,var/message = null) //This would normally go in emote.dm
	if(stat || !use_me && usr == src)
		to_chat(src, "You are unable to emote.")
		return

	//VOREStation Addition Start
	if(forced_psay)
		pme(message)
		return
	//VOREStation Addition End

	var/muzzled = is_muzzled()
	if(m_type == 2 && muzzled) return

	var/input
	if(!message)
		input = sanitize_or_reflect(tgui_input_text(src,"Choose an emote to display."), src)
	else
		input = message

	if(input)
		log_subtle(message,src)
		message = "<span class='emote_subtle'><B>[src]</B> <I>[input]</I></span>"
	else
		return

	if (message)
		var/undisplayed_message = "<span class='emote'><B>[src]</B> <I>does something too subtle for you to see.</I></span>"
		message = encode_html_emphasis(message)

		var/obj/belly/u_belly = get_ultimate_belly()
		var/mob/living/u_pred = u_belly?.owner || src

		var/list/vis = get_mobs_and_objs_in_view_fast(get_turf(src),1,2) //Turf, Range, and type 2 is emote
		var/list/vis_mobs = vis["mobs"]
		var/list/vis_objs = vis["objs"]

		var/valid_targets = list("One tile radius" = "otr", "Single tile" = "st", "All in belly and preds" = "aibap")
		for (var/mob/M as anything in vis_mobs)
			if (M == src)
				continue
			if (istype(M, /mob/living) && isturf(M.loc) && !u_belly)
				valid_targets["[M]"] = "\ref[M]"
				continue
			if (get_turf(M) == get_turf(src)) //so we aren't going through everything, it's a safe bet the belly is in the mob it's supposed to be in
				var/obj/belly/belly = M.get_ultimate_belly()
				if (belly?.owner == u_pred || u_pred == M)
					valid_targets["[M]"] = "\ref[M]"
		for (var/obj/item/i in vis_objs)
			if (LAZYLEN(i.possessed_voice) && i.get_ultimate_mob() == src)
				valid_targets["[i]"] = "\ref[i]"
		valid_targets += list("Cancel" = "c")
		valid_targets += list("Cancel and print to chat" = "captc")
		var/selected = input(src, "Choose the target to send it to.", "Subtle Distance", "One tile radius") as anything in valid_targets //default to one tile radius
		var/target = valid_targets[selected]
		if (target == "c" || isnull(target))
			return
		if (target == "captc")
			to_chat(src, "<span class='notice'>Cancelled message (pressed cancel): [message]</span>")
			return

		vis = get_mobs_and_objs_in_view_fast(get_turf(src),1,2) //in case it changed
		vis_mobs = vis["mobs"]
		vis_objs = vis["objs"]

		var/all_targets_mobs = list()
		var/all_targets_objs = list()

		var/cancelled

		switch(target)
			if ("otr", null)
				for (var/mob/M as anything in vis_mobs)
					if (get_dist(get_turf(src), get_turf(M)) < 2)
						all_targets_mobs |= M
				for (var/obj/M as anything in vis_objs)
					if (get_dist(get_turf(src), get_turf(M)) < 2)
						all_targets_objs |= M
			if ("st")
				for (var/mob/M as anything in vis_mobs)
					if (get_dist(get_turf(src), get_turf(M)) < 1)
						all_targets_mobs |= M
				for (var/obj/M as anything in vis_objs)
					if (get_dist(get_turf(src), get_turf(M)) < 1)
						all_targets_objs |= M
			if ("aibap")
				var/obj/belly/belly = get_ultimate_belly() //in case it's changed
				var/mob/pred = belly?.owner || src
				if (pred)
					all_targets_mobs |= pred.get_all_in_bellies()
					for (var/mob/living/M in vis_mobs)
						if (get_dist(get_turf(src), get_turf(M)) > 1)
							continue
						if (!isturf(M.loc) && !(M in all_targets_mobs)) //possessed items, mobs in bags, etc
							if (M.get_ultimate_belly() in pred.contents)
								all_targets_mobs |= M
						if (istype(M, /mob/living/dominated_brain) && M.get_ultimate_mob() == pred)
							all_targets_mobs |= M
					for (var/obj/item/i in vis_objs)
						if (LAZYLEN(i.possessed_voice) && (i.get_ultimate_belly() in pred.contents))
							all_targets_objs |= i
							all_targets_mobs |= i.possessed_voice
					all_targets_mobs |= pred
				else
					cancelled = "no belly owner"
			else
				var/target_reffed = locate(target)
				if (!target_reffed || (ismob(target_reffed) && !(target_reffed in vis_mobs)) || (isitem(target_reffed) && !(target_reffed in vis_objs)))
					cancelled = "mob not available"
				else
					if (ismob(target_reffed))
						all_targets_mobs |= target_reffed
					if (isitem(target_reffed))
						var/obj/item/i = target_reffed
						all_targets_objs |= target_reffed
						all_targets_mobs |= i.possessed_voice

		all_targets_mobs |= src

		if (cancelled)
			to_chat(src, "<span class='notice'>Cancelled message ([cancelled]): [message]</span>")
			return

		for(var/mob/M as anything in all_targets_mobs)
			if(isnewplayer(M))
				continue
			if(isobserver(M) && !is_preference_enabled(/datum/client_preference/whisubtle_vis) && !M.client?.holder)
				spawn(0)
					M.show_message(undisplayed_message, 2)
			else
				spawn(0)
					M.show_message(message, 2)
					if(M.is_preference_enabled(/datum/client_preference/subtle_sounds))
						M << sound('sound/talksounds/subtle_sound.ogg', volume = 50)

		for(var/obj/O as anything in all_targets_objs)
			spawn(0)
				O.see_emote(src, message, 2)

/mob/proc/emote_vr(var/act, var/type, var/message) //This would normally go in say.dm
	if(act == "me")
		return custom_emote_vr(type, message)

#define MAX_HUGE_MESSAGE_LEN 8192
#define POST_DELIMITER_STR "\<\>"
/proc/sanitize_or_reflect(message,user)
	//Way too long to send
	if(length(message) > MAX_HUGE_MESSAGE_LEN)
		fail_to_chat(user)
		return

	message = sanitize(message, max_length = MAX_HUGE_MESSAGE_LEN)

	//Came back still too long to send
	if(length(message) > MAX_MESSAGE_LEN)
		fail_to_chat(user,message)
		return null
	else
		return message

// returns true if it failed
/proc/reflect_if_needed(message, user)
	if(length(message) > MAX_HUGE_MESSAGE_LEN)
		fail_to_chat(user)
		return TRUE
	return FALSE

/proc/fail_to_chat(user,message)
	if(!message)
		to_chat(user, "<span class='danger'>Your message was NOT SENT, either because it was FAR too long, or sanitized to nothing at all.</span>")
		return

	var/length = length(message)
	var/posts = CEILING((length/MAX_MESSAGE_LEN), 1)
	to_chat(user,message)
	to_chat(user, "<span class='danger'>^ This message was NOT SENT ^ -- It was [length] characters, and the limit is [MAX_MESSAGE_LEN]. It would fit in [posts] separate messages.</span>")
#undef MAX_HUGE_MESSAGE_LEN

///// PSAY /////

/mob/verb/psay(message as text)
	set category = "IC"
	set name = "Psay"
	set desc = "Talk to people affected by complete absorbed or dominate predator/prey."

	if (src.client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, "<span class='warning'>You cannot speak in IC (muted).</span>")
			return
	if (!message)
		message = tgui_input_text(usr, "Type a message to say.","Psay")
	message = sanitize_or_reflect(message,src)
	if (!message)
		return
	message = capitalize(message)
	if (stat == DEAD)
		return say_dead(message)
	if(!isliving(src))
		forced_psay = FALSE
		say(message)
	var/f = FALSE		//did we find someone to send the message to other than ourself?
	var/mob/living/pb	//predator body
	var/mob/living/M = src
	if(istype(M, /mob/living/dominated_brain))
		var/mob/living/dominated_brain/db = M
		if(db.loc != db.pred_body)
			to_chat(db, "<span class='danger'>You aren't inside of a brain anymore!!!</span>")
			qdel(db)	//Oh no, dominated brains shouldn't exist outside of the body, so if we got here something went very wrong.
			return
		else
			pb = db.pred_body
			to_chat(pb, "<span class='changeling'>The captive mind of \the [M] thinks, \"[message]\"</span>")	//To our pred if dominated brain
			if(pb.is_preference_enabled(/datum/client_preference/subtle_sounds))
				pb << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
			f = TRUE
	else if(M.absorbed && isbelly(M.loc))
		pb = M.loc.loc
		to_chat(pb, "<span class='changeling'>\The [M] thinks, \"[message]\"</span>")	//To our pred if absorbed
		if(pb.is_preference_enabled(/datum/client_preference/subtle_sounds))
			pb << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
		f = TRUE

	if(pb)	//We are prey, let's do the prey thing.

		for(var/I in pb.contents)
			if(istype(I, /mob/living/dominated_brain) && I != M)
				var/mob/living/dominated_brain/db = I
				to_chat(db, "<span class='changeling'>The captive mind of \the [M] thinks, \"[message]\"</span>")	//To any dominated brains in the pred
				if(db.is_preference_enabled(/datum/client_preference/subtle_sounds))
					db << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
				f = TRUE
		for(var/B in pb.vore_organs)
			for(var/mob/living/L in B)
				if(L.absorbed && L != M && L.ckey)
					to_chat(L, "<span class='changeling'>\The [M] thinks, \"[message]\"</span>")	//To any absorbed people in the pred
					if(L.is_preference_enabled(/datum/client_preference/subtle_sounds))
						L << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
					f = TRUE

	//Let's also check and see if there's anyone inside of us to send the message to.
	for(var/I in M.contents)
		if(istype(I, /mob/living/dominated_brain))
			var/mob/living/dominated_brain/db = I
			to_chat(db, "<span class='changeling'><b>\The [M] thinks, \"[message]\"</b></span>")	//To any dominated brains inside us
			if(db.is_preference_enabled(/datum/client_preference/subtle_sounds))
				db << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
			f = TRUE
	for(var/B in M.vore_organs)
		for(var/mob/living/L in B)
			if(L.absorbed)
				to_chat(L, "<span class='changeling'><b>\The [M] thinks, \"[message]\"</b></span>")	//To any absorbed people inside us
				if(L.is_preference_enabled(/datum/client_preference/subtle_sounds))
					L << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
				f = TRUE

	if(f)	//We found someone to send the message to
		if(pb)
			to_chat(M, "<span class='changeling'>You think \"[message]\"</span>")	//To us if we are the prey
			if(M.is_preference_enabled(/datum/client_preference/subtle_sounds))
				M << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
		else
			to_chat(M, "<span class='changeling'><b>You think \"[message]\"</b></span>")	//To us if we are the pred
			if(M.is_preference_enabled(/datum/client_preference/subtle_sounds))
				M << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
		for (var/mob/G in player_list)
			if (istype(G, /mob/new_player))
				continue
			else if(isobserver(G) && G.is_preference_enabled(/datum/client_preference/ghost_ears))
				if(is_preference_enabled(/datum/client_preference/whisubtle_vis) || G.client.holder)
					to_chat(G, "<span class='changeling'>\The [M] thinks, \"[message]\"</span>")
		log_say(message,M)
	else		//There wasn't anyone to send the message to, pred or prey, so let's just say it instead and correct our psay just in case.
		M.forced_psay = FALSE
		M.say(message)

///// PME /////

/mob/verb/pme(message as message)
	set category = "IC"
	set name = "Pme"
	set desc = "Emote to people affected by complete absorbed or dominate predator/prey."

	if (src.client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, "<span class='warning'>You cannot speak in IC (muted).</span>")
			return
	if (!message)
		message = tgui_input_text(usr, "Type a message to emote.","Pme")
	message = sanitize_or_reflect(message,src)
	if (!message)
		return
	if (stat == DEAD)
		return say_dead(message)
	if(!isliving(src))
		forced_psay = FALSE
		me_verb(message)
	var/f = FALSE		//did we find someone to send the message to other than ourself?
	var/mob/living/pb	//predator body
	var/mob/living/M = src
	if(istype(M, /mob/living/dominated_brain))
		var/mob/living/dominated_brain/db = M
		if(db.loc != db.pred_body)
			to_chat(db, "<span class='danger'>You aren't inside of a brain anymore!!!</span>")
			qdel(db)	//Oh no, dominated brains shouldn't exist outside of the body, so if we got here something went very wrong.
			return
		else
			pb = db.pred_body
			to_chat(pb, "<span class='changeling'>\The [M] [message]</span>")	//To our pred if dominated brain
			if(pb.is_preference_enabled(/datum/client_preference/subtle_sounds))
				pb << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
			f = TRUE

	else if(M.absorbed && isbelly(M.loc))
		pb = M.loc.loc
		to_chat(pb, "<span class='changeling'>\The [M] [message]</span>")	//To our pred if absorbed
		if(pb.is_preference_enabled(/datum/client_preference/subtle_sounds))
			pb << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
		f = TRUE

	if(pb)	//We are prey, let's do the prey thing.

		for(var/I in pb.contents)
			if(istype(I, /mob/living/dominated_brain) && I != M)
				var/mob/living/dominated_brain/db = I
				to_chat(db, "<span class='changeling'>\The [M] [message]</span>")	//To any dominated brains in the pred
				if(db.is_preference_enabled(/datum/client_preference/subtle_sounds))
					db << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
				f = TRUE
		for(var/B in pb.vore_organs)
			for(var/mob/living/L in B)
				if(L.absorbed && L != M && L.ckey)
					to_chat(L, "<span class='changeling'>\The [M] [message]</span>")	//To any absorbed people in the pred
					if(L.is_preference_enabled(/datum/client_preference/subtle_sounds))
						L << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
					f = TRUE

	//Let's also check and see if there's anyone inside of us to send the message to.
	for(var/I in M.contents)
		if(istype(I, /mob/living/dominated_brain))
			var/mob/living/dominated_brain/db = I
			to_chat(db, "<span class='changeling'><b>\The [M] [message]</b></span>")	//To any dominated brains inside us
			if(db.is_preference_enabled(/datum/client_preference/subtle_sounds))
				db << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
			f = TRUE
	for(var/B in M.vore_organs)
		for(var/mob/living/L in B)
			if(L.absorbed)
				to_chat(L, "<span class='changeling'><b>\The [M] [message]</b></span>")	//To any absorbed people inside us
				if(L.is_preference_enabled(/datum/client_preference/subtle_sounds))
					L << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
				f = TRUE

	if(f)	//We found someone to send the message to
		if(pb)
			to_chat(M, "<span class='changeling'>\The [M] [message]</span>")	//To us if we are the prey
			if(M.is_preference_enabled(/datum/client_preference/subtle_sounds))
				M << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
		else
			to_chat(M, "<span class='changeling'><b>\The [M] [message]</b></span>")	//To us if we are the pred
			if(M.is_preference_enabled(/datum/client_preference/subtle_sounds))
				M << sound('sound/talksounds/subtle_sound.ogg', volume = 50)
		for (var/mob/G in player_list)
			if (istype(G, /mob/new_player))
				continue
			else if(isobserver(G) && G.is_preference_enabled(/datum/client_preference/ghost_ears))
				if(is_preference_enabled(/datum/client_preference/whisubtle_vis) || G.client.holder)
					to_chat(G, "<span class='changeling'>\The [M] [message]</span>")
		log_say(message,M)
	else	//There wasn't anyone to send the message to, pred or prey, so let's just emote it instead and correct our psay just in case.
		M.forced_psay = FALSE
		M.me_verb(message)

/mob/living/verb/player_narrate(message as message)
	set category = "IC"
	set name = "Narrate (Player)"
	set desc = "Narrate an action or event! An alternative to emoting, for when your emote shouldn't start with your name!"

	if(src.client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, "<span class='warning'>You cannot speak in IC (muted).</span>")
			return
	if(!message)
		message = tgui_input_text(usr, "Type a message to narrate.","Narrate")
	message = sanitize_or_reflect(message,src)
	if(!message)
		return
	if(stat == DEAD)
		return say_dead(message)
	if(stat)
		to_chat(src, "<span class= 'warning'>You need to be concious to narrate: [message]</span>")
		return
	message = "<span class='name'>([name])</span> <span class='pnarrate'>[message]</span>"

	//Below here stolen from emotes
	var/turf/T = get_turf(src)

	if(!T) return

	var/ourfreq = null
	if(voice_freq > 0 )
		ourfreq = voice_freq

	if(client)
		playsound(T, pick(emote_sound), 25, TRUE, falloff = 1 , is_global = TRUE, frequency = ourfreq, ignore_walls = FALSE, preference = /datum/client_preference/emote_sounds)

	var/list/in_range = get_mobs_and_objs_in_view_fast(T,world.view,2,remote_ghosts = client ? TRUE : FALSE)
	var/list/m_viewers = in_range["mobs"]

	for(var/mob/M as anything in m_viewers)
		if(M)
			if(isobserver(M))
				message = "[message] ([ghost_follow_link(src, M)])"
			if(isnewplayer(M))
				continue
			if(M.stat == UNCONSCIOUS || M.sleeping > 0)
				continue
			to_chat(M, message)
	log_emote(message, src)
