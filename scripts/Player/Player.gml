global.player_character = random(1) > 0.5 ? CHARACTERS.GIRL : CHARACTERS.GUY;
global.player_image_blend = make_color_rgb(random(255), random(255), random(255));

function player_create() {
	if (instance_exists(obj_player)) return;
	instance_create_depth(0, 0, 0, obj_player);
}

/**
 * Set player position.
 *
 * @param {Real} new_x
 * @param {Real} new_y
 */
function player_set_position(new_x, new_y) {
	with (obj_player) {
		pixel_move_set_position(pixel_move, new_x, new_y);
		x = pixel_move_get_x(pixel_move);
		y = pixel_move_get_y(pixel_move);
	}
}

function player_is_upper_half_of_screen() {
	// camera follows player
	var player = instance_find(obj_player, 0);
	var player_height = sprite_get_height(player.sprite_index);
	var player_y = player.y + player_height / 2;
	var camera_height = camera_get_view_height(view_camera[0]);
	var camera_y = camera_get_view_y(view_camera[0]) + camera_height / 2;
	return player_y <= camera_y;
}
