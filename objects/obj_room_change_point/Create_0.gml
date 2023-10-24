target_room = rm_change;
target_point = inst_35AC2325;

game_world_init_instance();

update = function() {
	if (place_meeting(x, y, obj_player)) room_change_set(id);
};
