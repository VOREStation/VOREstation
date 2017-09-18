/obj/item/weapon/game_kit
	name = "gaming kit"
	desc = "Allows you play chess, checkers, or whichever game involving those pieces."
	icon = 'icons/obj/items.dmi'
	icon_state = "game_kit"
	var/selected = null
	var/board_stat = null
	var/data = ""
	matter = list(DEFAULT_WALL_MATERIAL = 2000, "glass" = 1000)
	item_state = "sheet-metal"
	w_class = ITEMSIZE_HUGE

/obj/item/weapon/game_kit/New()
	board_stat = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
	selected = "CR"

/obj/item/weapon/game_kit/attack_hand(mob/user)
	return interact(user)

/obj/item/weapon/game_kit/proc/update()
	var/dat = text("<CENTER><B>Game Board</B></CENTER><BR><a href='?src=\ref[];mode=hia'>[]</a> <a href='?src=\ref[];mode=remove'>remove</a> <a href='?src=\ref[];reverse=\ref[src]'>invert board</a> <HR><table width= 256  border= 0  height= 256  cellspacing= 0  cellpadding= 0 >", src, (selected ? text("Selected: []", selected) : "Nothing Selected"), src, src)
	for (var/y = 1 to 8)
		dat += "<tr>"

		for (var/x = 1 to 8)
			var/color = (y + x) % 2 ? "#999999" : "#ffffff"
			var/piece = copytext(board_stat, ((y - 1) * 8 + x) * 2 - 1, ((y - 1) * 8 + x) * 2 + 1)
			dat += "<td>"
			dat += "<td style='background-color:[color]' width=32 height=32>"
			if (piece != "BB")
				dat += "<a href='?src=\ref[src];s_board=[x] [y]'><img src=board_[piece].png width=32 height=32 border=0>"
			else
				dat += "<a href='?src=\ref[src];s_board=[x] [y]'><img src=board_none.png width=32 height=32 border=0>"
			dat += "</td>"

		dat += "</tr>"

	dat += "</table><HR><B>Chips:</B><BR>"
	for (var/piece in list("CB", "CR"))
		dat += "<a href='?src=\ref[src];s_piece=[piece]'><img src=board_[piece].png width=32 height=32 border=0></a>"

	dat += "<HR><B>Chess pieces:</B><BR>"
	for (var/piece in list("WP", "WK", "WQ", "WI", "WN", "WR"))
		dat += "<a href='?src=\ref[src];s_piece=[piece]'><img src=board_[piece].png width=32 height=32 border=0></a>"
	dat += "<br>"
	for (var/piece in list("BP", "BK", "BQ", "BI", "BN", "BR"))
		dat += "<a href='?src=\ref[src];s_piece=[piece]'><img src=board_[piece].png width=32 height=32 border=0></a>"
	data = dat

/obj/item/weapon/game_kit/attack_ai(mob/user)
	return interact(user)

/obj/item/weapon/game_kit/interact(mob/user)
	user.machine = src
	if (!( data ))
		update()
	user << browse(data, "window=game_kit")
	onclose(user, "game_kit")


/obj/item/weapon/game_kit/Topic(href, href_list)
	..()
	if ((usr.stat || usr.restrained()))
		return

	if (usr.contents.Find(src) || (in_range(src, usr) && istype(loc, /turf)))
		if (href_list["s_piece"])
			selected = href_list["s_piece"]
		else if (href_list["mode"])
			if (href_list["mode"] == "remove")
				selected = "remove"
			else
				selected = null
		else if (href_list["reverse"])
			var/firstpart
			var/secondpart
			for (var/symbol = 65, symbol > 1, symbol-=2)
				firstpart += copytext(board_stat, symbol-2, symbol)

			for (var/symbol = 129, symbol > 65, symbol-=2)
				secondpart += copytext(board_stat, symbol-2, symbol)

			board_stat = secondpart + firstpart

		else if (href_list["s_board"])
			if (!( selected ))
				selected = href_list["s_board"]
			else
				var/tx = text2num(copytext(href_list["s_board"], 1, 2))
				var/ty = text2num(copytext(href_list["s_board"], 3, 4))
				if ((copytext(selected, 2, 3) == " " && length(selected) == 3))
					var/sx = text2num(copytext(selected, 1, 2))
					var/sy = text2num(copytext(selected, 3, 4))
					var/place = ((sy - 1) * 8 + sx) * 2 - 1
					selected = copytext(board_stat, place, place + 2)
					if (place == 1)
						board_stat = text("BB[]", copytext(board_stat, 3, 129))
					else
						if (place == 127)
							board_stat = text("[]BB", copytext(board_stat, 1, 127))
						else
							if (place)
								board_stat = text("[]BB[]", copytext(board_stat, 1, place), copytext(board_stat, place + 2, 129))
					place = ((ty - 1) * 8 + tx) * 2 - 1
					if (place == 1)
						board_stat = text("[][]", selected, copytext(board_stat, 3, 129))
					else
						if (place == 127)
							board_stat = text("[][]", copytext(board_stat, 1, 127), selected)
						else
							if (place)
								board_stat = text("[][][]", copytext(board_stat, 1, place), selected, copytext(board_stat, place + 2, 129))
					selected = null
				else
					if (selected == "remove")
						var/place = ((ty - 1) * 8 + tx) * 2 - 1
						if (place == 1)
							board_stat = text("BB[]", copytext(board_stat, 3, 129))
						else
							if (place == 127)
								board_stat = text("[]BB", copytext(board_stat, 1, 127))
							else
								if (place)
									board_stat = text("[]BB[]", copytext(board_stat, 1, place), copytext(board_stat, place + 2, 129))
					else
						if (length(selected) == 2)
							var/place = ((ty - 1) * 8 + tx) * 2 - 1
							if (place == 1)
								board_stat = text("[][]", selected, copytext(board_stat, 3, 129))
							else
								if (place == 127)
									board_stat = text("[][]", copytext(board_stat, 1, 127), selected)
								else
									if (place)
										board_stat = text("[][][]", copytext(board_stat, 1, place), selected, copytext(board_stat, place + 2, 129))
		add_fingerprint(usr)
		update()
		for(var/mob/M in viewers(1, src))
			if ((M.client && M.machine == src))
				interact(M)
