game_world_init_instance();

pixel_move = new PixelMove(x, y);
player_dir = DIR.SOUTH;

update = function() {
	var vel = 1;
	var vel_x = 0;
	var vel_y = 0;
		
	if (keyboard_check(vk_up)) vel_y -= vel;
	if (keyboard_check(vk_down)) vel_y += vel;
	if (keyboard_check(vk_left)) vel_x -= vel;
	if (keyboard_check(vk_right)) vel_x += vel;
	
	if (vel_x == 0 && vel_y > 0) {
		sprite_index = spr_player_s;
		id.player_dir = DIR.SOUTH;
	}
	if (vel_x == 0 && vel_y < 0) {
		sprite_index = spr_player_n;
		id.player_dir = DIR.NORTH;
	}
	if (vel_x < 0 && vel_y == 0) {
		sprite_index = spr_player_w;
		id.player_dir = DIR.WEST;
	}
	if (vel_x > 0 && vel_y == 0) {
		sprite_index = spr_player_e;
		id.player_dir = DIR.EAST;
	}
	
	var interact = instance_place(x, y, obj_interact);
	
	if (keyboard_check_pressed(vk_space) && interact != noone) {
		dialog_display_set_dialog(new Dialog(interact.dialog_data));
	} else {
		pixel_move_by_magnitudes_against(id.pixel_move, vel_x, vel_y, function (x, y) {
			return place_meeting(x, y, obj_wall);
		});
		x = pixel_move_get_x(id.pixel_move);
		y = pixel_move_get_y(id.pixel_move);
	}
};
