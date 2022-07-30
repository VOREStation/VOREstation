/obj/item/robot_module/drone/swarm
	name = "swarm drone module"
	var/id

/obj/item/robot_module/drone/swarm/Initialize(var/ml)

	. = ..()
	if(. != INITIALIZE_HINT_NORMAL)
		return

	var/mob/living/silicon/robot/R = loc
	id = R.idcard
	src.modules += id
	src.modules += new /obj/item/rcd/electric/mounted/borg/swarm(src)
	src.modules += new /obj/item/flash/robot(src)
	src.modules += new /obj/item/handcuffs/cable/tape/cyborg(src)
	src.modules += new /obj/item/melee/baton/robot(src)
	src.modules += new /obj/item/gun/energy/taser/mounted/cyborg/swarm(src)
	src.modules += new /obj/item/matter_decompiler/swarm(src)

/obj/item/robot_module/drone/swarm/ranged
	name = "swarm gunner module"

/obj/item/robot_module/drone/swarm/ranged/Initialize(var/ml)
	. = ..()
	if(. == INITIALIZE_HINT_NORMAL)
		modules += new /obj/item/gun/energy/xray/swarm(src)

/obj/item/robot_module/drone/swarm/melee/Initialize(var/ml)
	. = ..()
	if(. == INITIALIZE_HINT_NORMAL)
		modules += new /obj/item/melee/energy/sword/ionic_rapier/lance(src)

//Swarm Disabler Module
/obj/item/gun/energy/taser/mounted/cyborg/swarm
	name = "disabler"
	desc = "An archaic device which attacks the target's nervous-system or control circuits."
	icon_state = "disabler"
	projectile_type = /obj/item/projectile/beam/stun/disabler
	charge_cost = 800
	recharge_time = 0.5 SECONDS
