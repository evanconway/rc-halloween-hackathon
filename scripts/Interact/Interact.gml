global.interact_char_data = ds_map_create();

function interact_init_char_data() {
	if (!ds_map_exists(global.interact_char_data, id)) {
		ds_map_set(global.interact_char_data, id, {
			character: random(1) > 0.5 ? CHARACTERS.GIRL : CHARACTERS.GUY,
			image_blend: make_color_rgb(random(255), random(255), random(255))
		});
	}
	var data = ds_map_find_value(global.interact_char_data, id);
	character = data.character;
	image_blend = data.image_blend;
}

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
