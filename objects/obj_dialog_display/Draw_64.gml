if (global.dialog == undefined) exit;

draw_set_font(fnt_generic);
draw_set_color(c_white);
draw_set_alpha(1);

var height = string_height("A");
var cursor = 0;

var draw_x = floor(display_get_gui_width() / 2);
var draw_y = floor(display_get_gui_height() / 2);



// feather ignore GM1041
draw_text_ext(draw_x, draw_y + cursor * height, dialog_display_get_text(), height, 100);

cursor += 1;

var choices = dialog_get_choices_text(global.dialog);

for (var i = 0; i < array_length(choices); i++) {
	draw_text(draw_x + 30, draw_y + cursor * height, choices[i]);
	if (i == dialog_get_choice(global.dialog)) draw_text(draw_x, draw_y + cursor * height, ">");
	cursor += 1;
}
