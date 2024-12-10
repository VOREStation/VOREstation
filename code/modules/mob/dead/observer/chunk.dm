// CAMERA CHUNK
//
// A 16x16 grid of the map with a list of turfs that can be seen, are visible and are dimmed.
// Allows the Eye to stream these chunks and know what it can and cannot see.

/datum/chunk/ghost
	var/list/hidden_areas = list()

/datum/chunk/ghost/acquireVisibleTurfs(var/list/invisible)

	for(var/area/A in hidden_areas)

		var/turf/point = locate(src.x + 8, src.y + 8, src.z)
		if(get_dist(point, A) > 24)
			hidden_areas -= A

		for(var/turf/T in A.contents)
			invisible[T] = T

// Don't call the parernt, we work inverted!
/datum/chunk/ghost/New(loc, x, y, z)
	for(var/area/A in range(16, locate(x + 8, y + 8, z)))
		if(A.flag_check(AREA_BLOCK_GHOST_SIGHT))
			hidden_areas += A

	// 0xf = 15
	x &= ~0xf
	y &= ~0xf

	src.x = x
	src.y = y
	src.z = z

	for(var/turf/t in range(10, locate(x + 8, y + 8, z)))
		if(t.x >= x && t.y >= y && t.x < x + 16 && t.y < y + 16)
			turfs[t] = t

	acquireVisibleTurfs(obscuredTurfs)

	// Removes turf that isn't in turfs.
	obscuredTurfs &= turfs

	visibleTurfs = turfs - obscuredTurfs

	for(var/turf/t as anything in obscuredTurfs)
		LAZYINITLIST(t.obfuscations)
		if(!t.obfuscations[obfuscation.type])
			var/image/ob_image = image(obfuscation.icon, t, obfuscation.icon_state, OBFUSCATION_LAYER)
			ob_image.plane = PLANE_FULLSCREEN
			t.obfuscations[obfuscation.type] = ob_image
		obscured += t.obfuscations[obfuscation.type]

/datum/chunk/ghost/update()

	set background = 1

	var/list/newInvisibleTurfs = new()
	acquireVisibleTurfs(newInvisibleTurfs)

	// Removes turf that isn't in turfs.
	newInvisibleTurfs &= turfs

	var/list/visAdded = visibleTurfs - newInvisibleTurfs
	var/list/visRemoved = newInvisibleTurfs - visibleTurfs

	visibleTurfs = turfs - newInvisibleTurfs
	obscuredTurfs = newInvisibleTurfs

	for(var/turf/t as anything in visAdded)
		if(LAZYLEN(t.obfuscations) && t.obfuscations[obfuscation.type])
			obscured -= t.obfuscations[obfuscation.type]
			for(var/mob/observer/eye/m as anything in seenby)
				if(!m)
					continue
				var/client/client = m.GetViewerClient()
				if(client)
					client.images -= t.obfuscations[obfuscation.type]

	for(var/turf/t as anything in visRemoved)
		if(obscuredTurfs[t])
			LAZYINITLIST(t.obfuscations)
			if(!t.obfuscations[obfuscation.type])
				var/image/ob_image = image(obfuscation.icon, t, obfuscation.icon_state, OBFUSCATION_LAYER)
				ob_image.plane = PLANE_FULLSCREEN
				t.obfuscations[obfuscation.type] = ob_image

			obscured += t.obfuscations[obfuscation.type]
			for(var/mob/observer/eye/m as anything in seenby)
				if(!m)
					seenby -= m
					continue
				var/client/client = m.GetViewerClient()
				if(client)
					client.images += t.obfuscations[obfuscation.type]
