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
	var player = instance_find(obj_player, 0);
	show_debug_message($"({player.x}, {player.y})");
	
	camera_set_view_pos(view_camera[0], player.x, player.y);
}
