global.game_world_instances = [];

function game_world_init_instance() {
	update = function() {
		show_debug_message($"Game world instance id:{id} does not have defined update function.");
	};
	array_push(global.game_world_instances, id);
}

function game_world_update() {
	var game_world_instance_count = array_length(global.game_world_instances);
	for (var i = 0; i < game_world_instance_count; i++) {
		global.game_world_instances[i].update();
	}
}
