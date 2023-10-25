target_room = rm_change;
target_spawn = inst_9749ECB;

game_world_init_instance();

update = function() {
	if (place_meeting(x, y, obj_player)) room_change_set(target_room, target_spawn);
};
