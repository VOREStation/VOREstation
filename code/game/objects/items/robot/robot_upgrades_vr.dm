/obj/item/borg/upgrade/language/action(var/mob/living/silicon/robot/R)
	if(..())
		R.add_language(LANGUAGE_BIRDSONG,		1)
		R.add_language(LANGUAGE_SAGARU,			1)
		R.add_language(LANGUAGE_CANILUNZT,		1)
		R.add_language(LANGUAGE_ECUREUILIAN,	1)
		R.add_language(LANGUAGE_DAEMON,			1)
		R.add_language(LANGUAGE_ENOCHIAN,		1)
		return 1
	else
		return 0
