if (!room_change_active()) exit;

draw_set_alpha(global.room_change.alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
