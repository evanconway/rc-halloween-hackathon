game_world_init_instance();

pixel_move = new PixelMove(x, y);
player_dir = DIR.SOUTH;
interact_x = 0;
interact_y = 0;

update = function() {
	var vel = 1;
	var vel_x = 0;
	var vel_y = 0;
		
	if (keyboard_check(vk_up)) vel_y -= vel;
	if (keyboard_check(vk_down)) vel_y += vel;
	if (keyboard_check(vk_left)) vel_x -= vel;
	if (keyboard_check(vk_right)) vel_x += vel;
	
	pixel_move_by_magnitudes_against(id.pixel_move, vel_x, vel_y, function (x, y) {
			return place_meeting(x, y, obj_wall);
		});
	x = pixel_move_get_x(id.pixel_move);
	y = pixel_move_get_y(id.pixel_move);
	
	if (vel_x == 0 && vel_y > 0) id.player_dir = DIR.SOUTH;
	if (vel_x == 0 && vel_y < 0) id.player_dir = DIR.NORTH;
	if (vel_x < 0 && vel_y == 0) id.player_dir = DIR.WEST;
	if (vel_x > 0 && vel_y == 0) id.player_dir = DIR.EAST;
	
	// opposite angle fix
	if (vel_y < 0 && vel_x < 0 && !array_contains([DIR.NORTH, DIR.WEST], id.player_dir)) {
		id.player_dir = DIR.NORTH;
	}
	if (vel_y < 0 && vel_x > 0 && !array_contains([DIR.NORTH, DIR.EAST], id.player_dir)) {
		id.player_dir = DIR.NORTH;
	}
	if (vel_y > 0 && vel_x < 0 && !array_contains([DIR.SOUTH, DIR.WEST], id.player_dir)) {
		id.player_dir = DIR.SOUTH;
	}
	if (vel_y > 0 && vel_x > 0 && !array_contains([DIR.SOUTH, DIR.EAST], id.player_dir)) {
		id.player_dir = DIR.SOUTH;
	}
	
	var spacer = 2;
	
	if (id.player_dir == DIR.SOUTH) {
		sprite_index = spr_player_s;
		interact_x = x + sprite_get_width(sprite_index) / 2;
		interact_y = bbox_bottom + spacer;
	}
	if (id.player_dir == DIR.NORTH) {
		sprite_index = spr_player_n;
		interact_x = x + sprite_get_width(sprite_index) / 2;
		interact_y = bbox_top - 1 - spacer;
	}
	if (id.player_dir == DIR.WEST) {
		sprite_index = spr_player_w;
		interact_x = bbox_left - 1 - spacer;
		interact_y = y + sprite_get_height(sprite_index) / 2;
	}
	if (id.player_dir == DIR.EAST) {
		sprite_index = spr_player_e;
		interact_x = bbox_right + spacer;
		interact_y = y + sprite_get_height(sprite_index) / 2;
	}
	
	var interact = instance_position(interact_x, interact_y, obj_interact);
	
	if (keyboard_check_pressed(vk_space) && interact != noone) {
		dialog_display_set_dialog(new Dialog(interact.dialog_data));
	}
};
