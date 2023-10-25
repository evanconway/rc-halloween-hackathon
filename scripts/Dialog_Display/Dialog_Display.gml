function dialog_display_init() {
	global.dialog = undefined;
	global.text_cursor = 0;
	instance_create_depth(0, 0, 0, obj_dialog_display);
}

function dialog_display_active() {
	return global.dialog != undefined;
}

/*
TODO: find a way to initialize the obj_dialog_display object within this script
file instead of manually putting it in a room
*/

/**
 * Set new dialog to be displayed.
 *
 * @param {Struct.Dialog} dialog
 */
function dialog_display_set_dialog(dialog) {
	global.dialog = dialog;
	global.text_cursor = 0;
}

function dialog_display_get_text() {
	return string_copy(dialog_get_text(global.dialog), 0, floor(global.text_cursor));
}

function dialog_display_update() {
	var text_length = string_length(dialog_get_text(global.dialog));
	if (global.text_cursor < text_length) {
		global.text_cursor += 1.23;
		if (keyboard_check_pressed(vk_anykey)) global.text_cursor = text_length;
		return;
	}
	
	global.text_cursor = text_length;
	
	if (keyboard_check_pressed(vk_space)) {
		global.text_cursor = 0;
		// feather ignore GM1041
		if (dialog_is_at_end(global.dialog)) {
			global.dialog = undefined;
			exit;
		}
		dialog_advance(global.dialog);
	} else if (keyboard_check_pressed(vk_down)) {
		dialog_choice_increment(global.dialog);
	} else if (keyboard_check_pressed(vk_up)) {
		dialog_choice_decrement(global.dialog);
	}
}
