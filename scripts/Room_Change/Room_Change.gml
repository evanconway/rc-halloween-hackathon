global.room_change = {
	target_room: undefined,
	target_spawn: noone,
	state: 0,
	alpha: 0
};

function room_change_init() {
	instance_create_depth(0, 0, 0, obj_room_change);
}

/**
 * Trigger room change sequence to target room and spawn point.
 *
 * @param {Asset.GMRoom} target_room
 * @param {Id.Instance} target_spawn
 */
function room_change_set(target_room, target_spawn) {
	global.room_change.target_room = target_room;
	global.room_change.target_spawn = target_spawn;
}

/**
 * Get whether or not a room change is active.
 */
function room_change_active() {
	return global.room_change.target_room != undefined;
}

function room_change_update() {
	var alpha_change_rate = 0.02;
	if (global.room_change.state == 0) {
		global.room_change.alpha += alpha_change_rate;
		if (global.room_change.alpha >= 1) {
			global.room_change.state = 1;
			global.room_change.alpha = 1;
		}
	} else if (global.room_change.state == 1) {
		room_goto(global.room_change.target_room);
		global.room_change.state = 2;
	} else if (global.room_change.state == 2) {
		player_set_position(global.room_change.target_spawn.x, global.room_change.target_spawn.y);
		global.room_change.alpha -= alpha_change_rate;
		if (global.room_change.alpha <= 0) {
			global.room_change.state = 0;
			global.room_change.alpha = 0;
			global.room_change.target_room = undefined;
			global.room_change.target_spawn = noone;
		}
	}
}
