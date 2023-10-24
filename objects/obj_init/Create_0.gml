camera_init_basic(320, 180, 5);
dialog_display_init();
room_change_init();
instance_create_depth(0, 0, 0, obj_app);

var trigger = instance_create_depth(0, 0, 0, obj_room_change_trigger);
trigger.target_room = rm_first;
trigger.target_spawn = inst_3CD828F2;
room_change_set(trigger);
