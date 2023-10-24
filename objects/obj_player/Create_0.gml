game_world_init_instance();

update = function() {
	var interact = instance_place(x, y, obj_interact);
	if (keyboard_check_pressed(vk_space) && interact != noone) {
		dialog_display_set_dialog(new Dialog(interact.dialog_data));
	} else {
		var vel = 1;
		if (keyboard_check(vk_up)) y -= vel;
		if (keyboard_check(vk_down)) y += vel;
		if (keyboard_check(vk_left)) x -= vel;
		if (keyboard_check(vk_right)) x += vel;
	}
};
