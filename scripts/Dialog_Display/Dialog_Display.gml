function dialog_display_init() {
	global.dialog = undefined;
	global.interact = noone;
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
 * @param {Id.Instance} interact
 */
function dialog_display_set_dialog(interact) {
	global.dialog = new Dialog(interact.dialog_data);
	global.interact = interact;
}


function dialog_display_update() {
	if (keyboard_check_pressed(vk_space)) {
		// feather ignore GM1041
		if (dialog_is_at_end(global.dialog)) {
			global.dialog = undefined;
			var interact = global.interact;
			interact.sprite_index = character_sprite(interact.character, interact.dir);
			exit;
		}
		dialog_advance(global.dialog);
	} else if (keyboard_check_pressed(vk_down)) {
		dialog_choice_increment(global.dialog);
	} else if (keyboard_check_pressed(vk_up)) {
		dialog_choice_decrement(global.dialog);
	}
}
