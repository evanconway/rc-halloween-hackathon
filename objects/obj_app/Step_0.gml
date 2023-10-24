if (room_change_active()) room_change_update();
else if (dialog_display_active()) dialog_display_update();
else game_world_update();
