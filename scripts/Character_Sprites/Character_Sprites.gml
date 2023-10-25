enum CHARACTERS {
	GUY,
	GIRL
}

/**
 * Get sprite asset for given character and direction.
 *
 * @param {Real} character
 * @param {Real} dir
 */
function character_sprite(character, dir) {
	// guy
	if (character == CHARACTERS.GUY && dir == DIR.SOUTH) return spr_guy_s;
	if (character == CHARACTERS.GUY && dir == DIR.NORTH) return spr_guy_n;
	if (character == CHARACTERS.GUY && dir == DIR.EAST) return spr_guy_e;
	if (character == CHARACTERS.GUY && dir == DIR.WEST) return spr_guy_w;
	// girl
	if (character == CHARACTERS.GIRL && dir == DIR.SOUTH) return spr_girl_s;
	if (character == CHARACTERS.GIRL && dir == DIR.NORTH) return spr_girl_n;
	if (character == CHARACTERS.GIRL && dir == DIR.EAST) return spr_girl_e;
	if (character == CHARACTERS.GIRL && dir == DIR.WEST) return spr_girl_w;
}
