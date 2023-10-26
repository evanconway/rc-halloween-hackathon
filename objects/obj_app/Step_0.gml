player_create();

if (room_change_active()) room_change_update();
else if (dialog_display_active()) dialog_display_update();
else game_world_update();

// camera follows player
if (instance_exists(obj_player)) {
	var player = instance_find(obj_player, 0);
	var camera_width = camera_get_view_width(view_camera[0]);
	var camera_height = camera_get_view_height(view_camera[0]);
	var player_width = sprite_get_width(player.sprite_index);
	var player_height = sprite_get_height(player.sprite_index);
	var camera_x = player.x - camera_width / 2 + player_width / 2;
	var camera_y = player.y - camera_height / 2 + player_height / 2;
	camera_x = clamp(camera_x, 0, room_width - camera_width);
	camera_y = clamp(camera_y, 0, room_height - camera_height);
	camera_set_view_pos(view_camera[0], camera_x, camera_y);
}
