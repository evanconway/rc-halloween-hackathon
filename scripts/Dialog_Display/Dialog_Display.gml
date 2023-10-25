function dialog_display_init() {
	global.dialog = undefined;
	global.text_cursor = 0;
	global.text_advance = 0;
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
	global.text_cursor = 1;
}

function dialog_display_get_text() {
	return string_copy(dialog_get_text(global.dialog), 1, floor(global.text_cursor) - 1);
}

function dialog_display_get_choice() {
	return dialog_get_choice(global.dialog);
}

function dialog_display_typing_finished() {
	if (!dialog_display_active()) return false;
	return global.text_cursor == string_length(dialog_get_text(global.dialog)) + 1;
}

function dialog_display_update() {
	var text = dialog_get_text(global.dialog);
	var text_length = string_length(text);
	if (global.text_cursor <= text_length) {
		global.text_advance += 0.1;
		if (global.text_advance >= 1) {
			global.text_advance = 0;
			global.text_cursor = string_pos_ext(" ", text, global.text_cursor + 1);
		}
		if (keyboard_check_pressed(vk_anykey) || global.text_cursor <= 0) global.text_cursor = text_length + 1;
		return;
	}
	
	global.text_cursor = text_length + 1;
	
	if (keyboard_check_pressed(vk_space)) {
		global.text_cursor = 1;
		global.text_advance = 0;
		// feather ignore GM1041
		if (dialog_is_at_end(global.dialog)) {
			global.dialog = undefined;
			exit;
		}
		dialog_advance(global.dialog);
	} else if (keyboard_check_pressed(vk_right)) {
		dialog_choice_increment(global.dialog);
	} else if (keyboard_check_pressed(vk_left)) {
		dialog_choice_decrement(global.dialog);
	}
}
