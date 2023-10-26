dialog_display_init();
room_change_init();
room_change_set(rm_floor_4, inst_F6575EE);
play_sound(snd_music_ambient, true);
randomize();

global.player_character = random(1) > 0.5 ? CHARACTERS.GIRL : CHARACTERS.GUY;
global.player_image_blend = make_color_rgb(random(255), random(255), random(255));
