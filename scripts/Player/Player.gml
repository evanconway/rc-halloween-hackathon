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
