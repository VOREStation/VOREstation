
/obj/screen/movable/action_button
	var/datum/action/linked_action
	var/actiontooltipstyle = ""
	screen_loc = null

	var/button_icon_state
	var/appearance_cache

/obj/screen/movable/action_button/Click(location,control,params)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		moved = FALSE
		usr.update_action_buttons()
		return 1
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		locked = !locked
		to_chat(usr, span_notice("Action button \"[name]\" [locked ? "" : "un"]locked."))
		return TRUE
	if(!usr.checkClickCooldown())
		return
	usr.setClickCooldown(1)
	linked_action.Trigger()
	return TRUE

//Hide/Show Action Buttons ... Button
/obj/screen/movable/action_button/hide_toggle
	name = "Hide Buttons"
	desc = "Shift-click any button to reset its position, and Control-click it to lock it in place. Alt-click this button reset all buttons to their default positions."
	icon = 'icons/mob/actions.dmi'
	icon_state = "bg_default"
	var/hidden = 0

/obj/screen/movable/action_button/hide_toggle/Click(location, control, params)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		moved = FALSE
		usr.update_action_buttons(TRUE)
		return TRUE
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		locked = !locked
		to_chat(usr, span_notice("Action button \"[name]\" [locked ? "" : "un"]locked."))
		return TRUE
	if(LAZYACCESS(modifiers, ALT_CLICK))
		AltClick(usr)
		return TRUE

	usr.hud_used.action_buttons_hidden = !usr.hud_used.action_buttons_hidden

	hidden = usr.hud_used.action_buttons_hidden
	if(hidden)
		name = "Show Buttons"
	else
		name = "Hide Buttons"
	UpdateIcon()
	usr.update_action_buttons()

/obj/screen/movable/action_button/hide_toggle/AltClick(mob/user)
	for(var/datum/action/A as anything in user.actions)
		var/obj/screen/movable/action_button/B = A.button
		B.moved = FALSE
		// B.locked = usr.client.prefs.buttons_locked
	// locked = usr.client.prefs.buttons_locked
	moved = FALSE
	user.update_action_buttons(TRUE)
	to_chat(user, span_notice("Action button positions have been reset."))

/obj/screen/movable/action_button/hide_toggle/proc/InitialiseIcon(mob/user)
	// var/settings = owner_hud.get_action_buttons_icons()
	// icon = settings["bg_icon"]
	// icon_state = settings["bg_state"]
	// hide_icon = settings["toggle_icon"]
	// hide_state = settings["toggle_hide"]
	// show_state = settings["toggle_show"]
	if(isalien(user))
		icon_state = "bg_alien"
	else
		icon_state = "bg_default"
	UpdateIcon()

/obj/screen/movable/action_button/hide_toggle/proc/UpdateIcon()
	cut_overlays()
	add_overlay(mutable_appearance(icon, hidden ? "show" : "hide"))
	// add_overlay(mutable_appearance(hide_icon, hidden ? show_state : hide_state))

/obj/screen/movable/action_button/MouseEntered(location, control, params)
	openToolTip(usr, src, params, title = name, content = desc, theme = actiontooltipstyle)

/obj/screen/movable/action_button/MouseExited(location, control, params)
	closeToolTip(usr)

// /datum/hud/proc/get_action_buttons_icons()
// 	. = list()
// 	.["bg_icon"] = ui_style_icon
// 	.["bg_state"] = "template"

// 	//TODO : Make these fit theme
// 	.["toggle_icon"] = 'icons/mob/actions.dmi'
// 	.["toggle_hide"] = "hide"
// 	.["toggle_show"] = "show"

//used to update the buttons icon.
/mob/proc/update_action_buttons_icon(status_only = FALSE)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon(status_only)

//This is the proc used to update all the action buttons.
/mob/proc/update_action_buttons(reload_screen)
	if(!hud_used || !client)
		return

	if(!hud_used.hud_shown)	//Hud toggled to minimal
		return

	var/button_number = 0

	if(hud_used.action_buttons_hidden)
		for(var/datum/action/A in actions)
			A.button.screen_loc = null
			if(reload_screen)
				client.screen += A.button
	else
		for(var/datum/action/A in actions)
			button_number++
			A.UpdateButtonIcon()
			var/obj/screen/movable/action_button/B = A.button
			if(!B.moved)
				B.screen_loc = hud_used.ButtonNumberToScreenCoords(button_number)
			else
				B.screen_loc = B.moved
			if(reload_screen)
				client.screen += B

		if(!button_number)
			hud_used.hide_actions_toggle?.screen_loc = null
			return

	// not exactly sure how this happens but it does
	if(hud_used.hide_actions_toggle)
		if(!hud_used.hide_actions_toggle.moved)
			hud_used.hide_actions_toggle.screen_loc = hud_used.ButtonNumberToScreenCoords(button_number+1)
		else
			hud_used.hide_actions_toggle.screen_loc = hud_used.hide_actions_toggle.moved
		if(reload_screen)
			client.screen += hud_used.hide_actions_toggle

#define AB_WEST_OFFSET 4
#define AB_NORTH_OFFSET 26
#define AB_MAX_COLUMNS 10

/datum/hud/proc/ButtonNumberToScreenCoords(var/number) // TODO : Make this zero-indexed for readabilty
	var/row = round((number-1)/AB_MAX_COLUMNS)
	var/col = ((number - 1)%(AB_MAX_COLUMNS)) + 1

	var/coord_col = "+[col-1]"
	var/coord_col_offset = AB_WEST_OFFSET+2*col

	var/coord_row = "[-1 - row]"
	var/coord_row_offset = AB_NORTH_OFFSET

	return "WEST[coord_col]:[coord_col_offset],NORTH[coord_row]:[coord_row_offset]"

/datum/hud/proc/SetButtonCoords(var/obj/screen/button,var/number)
	var/row = round((number-1)/AB_MAX_COLUMNS)
	var/col = ((number - 1)%(AB_MAX_COLUMNS)) + 1
	var/x_offset = 32*(col-1) + AB_WEST_OFFSET + 2*col
	var/y_offset = -32*(row+1) + AB_NORTH_OFFSET

	var/matrix/M = matrix()
	M.Translate(x_offset,y_offset)
	button.transform = M

#undef AB_WEST_OFFSET
#undef AB_NORTH_OFFSET
#undef AB_MAX_COLUMNS
