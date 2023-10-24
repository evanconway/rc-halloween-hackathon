global.room_change = {
	point_start: noone,
	point_end: noone,
	state: 0,
	alpha: 0
};

function room_change_init() {
	instance_create_depth(0, 0, 0, obj_room_change);
}

/**
 * Trigger room change sequence to given change point.
 *
 * @param {Id.Instance} room_change_point
 */
function room_change_set(room_change_point) {
	global.room_change.point_start = room_change_point;
	global.room_change.point_end = room_change_point == noone ? noone : room_change_point.target_point;
}

/**
 * Get whether or not a room change is active.
 */
function room_change_active() {
	return global.room_change.point_start != noone;
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
		room_goto(global.room_change.point_start.target_room);
		global.room_change.state = 2;
	} else if (global.room_change.state == 2) {
		with (obj_player) {
			// TODO: Consider setting player position here
			// x = global.room_change.point_end.x;
			// y = global.room_change.point_end.y;
		}
		global.room_change.alpha -= alpha_change_rate;
		if (global.room_change.alpha <= 0) {
			global.room_change.state = 0;
			global.room_change.alpha = 0;
			room_change_set(noone);
		}
	}
}
