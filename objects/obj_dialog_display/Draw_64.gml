if (global.dialog == undefined) exit;

draw_set_font(fnt_generic);
draw_set_alpha(1);

// draw background box
draw_set_color(c_black);

var box_width = 150;
var box_height = 70;

var box_x = display_get_gui_width() / 2 - box_width / 2;
var box_y = display_get_gui_height() - box_height - 10;

draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);


draw_set_color(c_white);
draw_set_alpha(1);

var height = string_height("A");

var draw_x = floor(display_get_gui_width() / 2);
var draw_y = floor(display_get_gui_height() / 2);

var spacer = 6;

// feather ignore GM1041
draw_text_ext(
	box_x + spacer,
	box_y + spacer,
	dialog_display_get_text(),
	height,
	box_width - spacer * 2
);

var choices = dialog_get_choices_text(global.dialog);

var choice_spacer = spacer;

var choices_width = 0;
for (var i = 0; i < array_length(choices); i++) {
	choices_width += string_width(choices[i]);
	if (i < array_length(choices) - 1) choices_width += choice_spacer;
}

var choices_x = display_get_gui_width() / 2 - choices_width / 2;
var choices_y = box_y + box_height - spacer - height;

for (var i = 0; i < array_length(choices); i++) {
	draw_set_color(i == dialog_display_get_choice() ? c_white : c_gray);
	draw_text(choices_x, choices_y, choices[i]);
	choices_x += string_width(choices[i]) + choice_spacer;
}
