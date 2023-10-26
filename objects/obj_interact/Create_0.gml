game_world_init_instance();

draw_set_color(c_red);

dialog_data = ["No dialog defined yet."];

character = random(1) > 0.5 ? CHARACTERS.GIRL : CHARACTERS.GUY;
dir_reset_countdown = 0;
image_speed = 0;

interact_set_direction(DIR.SOUTH);

update = function() {
	if (dir_reset_countdown > 0) dir_reset_countdown -= 1;
	if (dir_reset_countdown <= 0 && dir != original_dir) {
		dir = original_dir;
		sprite_index = character_sprite(character, dir);
	}
}
