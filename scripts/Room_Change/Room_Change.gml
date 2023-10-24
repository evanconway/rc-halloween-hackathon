global.room_change = {
	trigger: noone,
	spawn: noone,
	state: 0,
	alpha: 0
};

function room_change_init() {
	instance_create_depth(0, 0, 0, obj_room_change);
}

/**
 * Trigger room change sequence from given trigger.
 *
 * @param {Id.Instance} trigger
 */
function room_change_set(trigger) {
	global.room_change.trigger = trigger;
	global.room_change.spawn = trigger == noone ? noone : trigger.target_spawn;
}

/**
 * Get whether or not a room change is active.
 */
function room_change_active() {
	return global.room_change.trigger != noone;
}

function room_change_update() {
	var alpha_change_rate = 0.015;
	if (global.room_change.state == 0) {
		global.room_change.alpha += alpha_change_rate;
		if (global.room_change.alpha >= 1) {
			global.room_change.state = 1;
			global.room_change.alpha = 1;
		}
	} else if (global.room_change.state == 1) {
		room_goto(global.room_change.trigger.target_room);
		global.room_change.state = 2;
	} else if (global.room_change.state == 2) {
		player_set_position(global.room_change.spawn.x, global.room_change.spawn.y);
		global.room_change.alpha -= alpha_change_rate;
		if (global.room_change.alpha <= 0) {
			global.room_change.state = 0;
			global.room_change.alpha = 0;
			room_change_set(noone);
		}
	}
}
