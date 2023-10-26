global.sound_id_map = ds_map_create();

/**
 *
 *
 * @param {Asset.GMSound} sound
 * @param {bool} loop
 */
function play_sound(sound, loop=false) {
	// stop sound if playing
	if (ds_map_exists(global.sound_id_map, sound)) {
		audio_stop_sound(ds_map_find_value(global.sound_id_map, sound));
	}
	var sound_id = audio_play_sound(sound, 0, loop);
	ds_map_set(global.sound_id_map, sound, sound_id);
}
