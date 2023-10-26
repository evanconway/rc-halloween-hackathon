global.music_id = 0;

function play_music() {
	audio_stop_sound(global.music_id);
	global.music_id = audio_play_sound(snd_music_ambient, 0, true);
}
