//Body snatcher. Based off the sleevemate, but instead of storing a mind it lets you swap your mind with someone. Extremely illegal and being caught with one s
/obj/item/device/bodysnatcher
	name = "\improper Body Snatcher Device"
	desc = "An extremely illegal tool that allows the user to swap minds with the selected humanoid victim. "
	icon = 'icons/obj/device_alt.dmi'
	icon_state = "sleevemate" //Give this a fancier sprite later.
	item_state = "healthanalyzer"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_SMALL
	matter = list(DEFAULT_WALL_MATERIAL = 200)
	origin_tech = list(TECH_MAGNET = 2, TECH_BIO = 2, TECH_ILLEGAL = 1)

/obj/item/device/bodysnatcher/New()
	..()
	flags |= NOBLUDGEON //So borgs don't spark.

/obj/item/device/bodysnatcher/attack(mob/living/M, mob/living/user)
	usr.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	if(ishuman(M) || issilicon(M)) //Allows body swapping with humans, synths, and pAI's/borgs since they all have a mind.
		if(!M.mind) //Do they have a mind?
			to_chat(usr,"<span class='warning'>A warning pops up on the device, informing you that [M] appears braindead.</span>")
			return
		if(M.stat == DEAD) //Are they dead?
			to_chat(usr,"<span class='warning'>A warning pops up on the device, informing you that [M] is dead, and, as such, the mind transfer can not be done.</span>")
			return
		var/choice = alert(usr,"This will swap your mind with the target's mind. This will result in them controlling your body, and you controlling their body. Continue?","Confirmation","Continue","Cancel")
		if(choice == "Continue" && usr.get_active_hand() == src && usr.Adjacent(M))

			usr.visible_message("<span class='warning'>[usr] pushes the device up his forehead and [M]'s head, the device beginning to let out a series of light beeps!</span>","<span class='notice'>You begin swap minds with [M]!</span>")
			if(do_after(usr,35 SECONDS,M))
				if(usr.mind && M.mind && M.stat != DEAD && usr.stat != DEAD)
					var/user_mind = usr.mind
					var/target_mind = M.mind
					var/target_ooc_notes = M.ooc_notes
					var/user_ooc_notes = user.ooc_notes
					var/user_ckey = user.ckey
					var/target_ckey = M.ckey
					log_and_message_admins("[usr.ckey] used a Bodysnatcher to swap bodies with [M.ckey]")
					to_chat(usr,"<span class='notice'>Your minds have been swapped! Have a nice day.</span>")
					M.ghostize() //If this doesn't happen, it boots them from the server.
					usr.ghostize()
					M.mind = null //Let's make them null for a second, just a precaution
					usr.mind = null
					M.mind = user_mind //Now, let's swap their minds. Would use transfer_to, but the issue with that is you can't move X's mind to Y, then Y's mind to X, as Y's mind would be overwritten by X's mind at that point.
					usr.mind = target_mind
					usr.ckey = target_ckey //Can't see an
					M.ckey = user_ckey
					user.apply_vore_prefs()
					M.apply_vore_prefs()
					M.ooc_notes = user_ooc_notes //Let's keep their OOC notes over to their new body.
					user.ooc_notes = target_ooc_notes
					usr.sleeping = 10 //Device knocks out both the user and the target.
					usr.eye_blurry = 30 //Blurry vision while they both get used to their new body's vision
					usr.slurring = 50 //And let's also have them slurring while they attempt to get used to using their new body.
					if(ishuman(M))
						M.sleeping = 10
						M.eye_blurry = 30
						M.slurring = 50

	else
		to_chat(user,"<span class='warning'> A warning pops up on the LED display on the side of the device, informing you that the target is not able to have their mind swapped with!</span>")

/obj/item/device/bodysnatcher/attack_self(mob/living/user)
		to_chat(user,"<span class='warning'> A message pops up on the LED display, informing you that you that the mind transfer to yourself was successful... Wait, did that even do anything?</span>")
		return
