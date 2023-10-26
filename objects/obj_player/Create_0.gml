game_world_init_instance();

image_speed = 0;
pixel_move = new PixelMove(x, y);
player_dir = DIR.EAST;
interact_x = 0;
interact_y = 0;
character = CHARACTERS.GUY;
frame_progress = 0;

sprite_index = character_sprite(character, player_dir);

update = function() {
	var vel = 1;
	var vel_x = 0;
	var vel_y = 0;
	
	if (keyboard_check_pressed(vk_up)) player_dir = DIR.NORTH;
	if (keyboard_check_pressed(vk_down)) player_dir = DIR.SOUTH;
	if (keyboard_check_pressed(vk_left)) player_dir = DIR.WEST;
	if (keyboard_check_pressed(vk_right)) player_dir = DIR.EAST;
	
	if (keyboard_check(vk_up) && player_dir == DIR.NORTH) vel_y -= vel;
	if (keyboard_check(vk_down) && player_dir == DIR.SOUTH) vel_y += vel;
	if (keyboard_check(vk_left) && player_dir == DIR.WEST) vel_x -= vel;
	if (keyboard_check(vk_right) && player_dir == DIR.EAST) vel_x += vel;
	
	pixel_move_by_magnitudes_against(id.pixel_move, vel_x, vel_y, function (pos_x, pos_y) {
		return place_meeting(pos_x, pos_y, obj_wall);
	});
	x = pixel_move_get_x(id.pixel_move);
	y = pixel_move_get_y(id.pixel_move);
	
	var spacer = 2;
	
	if (id.player_dir == DIR.SOUTH) {
		interact_x = x + sprite_get_width(sprite_index) / 2;
		interact_y = bbox_bottom + spacer;
	}
	if (id.player_dir == DIR.NORTH) {
		interact_x = x + sprite_get_width(sprite_index) / 2;
		interact_y = bbox_top - 1 - spacer;
	}
	if (id.player_dir == DIR.WEST) {
		interact_x = bbox_left - 1 - spacer;
		interact_y = y + sprite_get_height(sprite_index) / 2;
	}
	if (id.player_dir == DIR.EAST) {
		interact_x = bbox_right + spacer;
		interact_y = y + sprite_get_height(sprite_index) / 2;
	}
	
	sprite_index = character_sprite(id.character, id.player_dir);
	if (vel_x == 0 && vel_y == 0) frame_progress = 0;
	else if (frame_progress == 0) {
		frame_progress = 1;
	} else {
		frame_progress += 0.1;
	}
	image_index = id.frame_progress;
	
	var interact = instance_position(interact_x, interact_y, obj_interact);
	
	if (keyboard_check_pressed(vk_space) && interact != noone) {
		dialog_display_set_dialog(new Dialog(interact.dialog_data));
		
		// set interact sprite to face player
		var diff_x = abs(interact.x - x);
		var diff_y = abs(interact.y - y);
		var new_dir = DIR.SOUTH;
		if (diff_x > diff_y) {
			new_dir = x < interact.x ? DIR.WEST : DIR.EAST;
			interact.sprite_index = character_sprite(interact.character, new_dir);
		} else {
			new_dir = y < interact.y ? DIR.NORTH : DIR.SOUTH;
			interact.sprite_index = character_sprite(interact.character, new_dir);
		}
		interact.dir_reset_countdown = 100;
		interact.dir = new_dir;
	}
};
