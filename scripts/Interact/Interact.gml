/*
 * Set interact object direction. Only call from interact object.
 *
 * @param {real} new_dir
 */
function interact_set_direction(new_dir=DIR.SOUTH) {
	original_dir = new_dir;
	dir = original_dir;
	sprite_index = character_sprite(character, dir);
}

function interact_set_dialog_and_invisible(new_dialog_data) {
	dialog_data = new_dialog_data;
	image_alpha = 0;
}
