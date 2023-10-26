enum DIR {
	NORTH,
	SOUTH,
	EAST,
	WEST
}

global.game_world_instances = ds_map_create();

function game_world_init_instance() {
	update = function() {
		show_debug_message($"Game world instance id:{id} does not have defined update function.");
	};
	ds_map_set(global.game_world_instances, id, noone);
}

function game_world_update() {
	var ids = ds_map_keys_to_array(global.game_world_instances);
	var game_world_instance_count = array_length(ids);
	for (var i = 0; i < game_world_instance_count; i++) {
		if (instance_exists(ids[i])) ids[i].update();
		else ds_map_delete(global.game_world_instances, ids[i]);
	}
	
	// camera follows player
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
