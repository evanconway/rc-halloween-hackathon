/**
 * Get a new Dialog instance.
 *
 * @param {Array<Any>} steps
 */
function Dialog(steps) constructor {
	if (!is_array(steps) || array_length(steps) <= 0) throw("Dialog steps must be array of size 1 or greater.");
	
	current_step_name = "";
	choice = 0;
	language_index = 0;
	
	static get_blank_step = function() {
		return {
			name: "",
			text: [], // Array<String>
			choices: [], // Array<{ text: Array<String>, goto: String}> or undefined
			data: undefined,
		}
	};
	
	/**
	 * If given array of strings returns same array. If given a string return new array containing only the given string.
	 *
	 * @param {string, Array<string>} text_string_or_array
	 * @return {Array<string>} 
	 */
	static get_text_from_text = function(text_string_or_array) {
		// feather disable GM1045 once
		if (is_array(text_string_or_array)) return text_string_or_array;
		if (is_string(text_string_or_array)) return [text_string_or_array];
		throw("get_text_from_text was given input that is neither an array or a string");
	};
	
	var steps_length = array_length(steps);
	dialog_steps = array_create(steps_length);
	step_map = ds_map_create();
	
	// iterate over given steps and convert shorthand steps to full steps
	for (var i = 0; i < steps_length; i++) {
		dialog_steps[i] = get_blank_step();
		dialog_steps[i].name = $"auto_{i}";
		dialog_steps[i].choices = undefined; // set undefined to assume only choice is next step
		if (is_struct(steps[i])) {
			if (variable_struct_exists(steps[i], "name")) dialog_steps[i].name = steps[i].name;
			dialog_steps[i].text = get_text_from_text(steps[i].text);
			if (variable_struct_exists(steps[i], "choices")) dialog_steps[i].choices = steps[i].choices;
			if (variable_struct_exists(steps[i], "data")) dialog_steps[i].data = steps[i].data;
		}
		if (is_array(steps[i]) || is_string(steps[i])) {
			dialog_steps[i].text = get_text_from_text(steps[i]);
		}
		ds_map_set(step_map, dialog_steps[i].name, undefined);
	}
	
	// all text and choices should have the same number of languages
	var num_of_langs = array_length(dialog_steps[0].text);
	
	// define choices for steps with undefined choices, ensure defined choices are valid, and ensure text and choice length are all the same
	for (var i = 0; i < steps_length; i++) {
		var step = dialog_steps[i];
		if (array_length(step.text) != num_of_langs) throw("Dialog steps must all have same number of languages in text.");
		if (step.choices == undefined) {
			if (i == steps_length - 1) step.choices = [];
			else step.choices = [{ text: [], goto: dialog_steps[i + 1].name }];
		}
		
		for (var c = 0; c < array_length(step.choices); c++) {
			// choice languages must be same number as text or 0
			var choice_num_of_langs = array_length(step.choices[c].text);
			if (choice_num_of_langs > 0 && choice_num_of_langs != num_of_langs) throw("Dialog steps must all have same number of languages in text.");
			var choice_name = step.choices[c].goto;
			if (!ds_map_exists(step_map, choice_name)) throw($"step name {step.name} index {i} choice {c} has invalid goto {choice_name}");
			step.choices[c].text = get_text_from_text(step.choices[c].text);
		}
		ds_map_set(step_map, step.name, step);
	}
	
	current_step_name = dialog_steps[0].name;
	
	static get_current_step = function() {
		return ds_map_find_value(step_map, current_step_name);
	};
}

/**
 * Returns the text of the current step and language index.
 *
 * @param {Struct.Dialog} dialog
 * @return {string}
 */
function dialog_get_text(dialog) {
	with (dialog) {
		// feather ignore GM1045 once
		return get_current_step().text[language_index];
	}
}

/**
 * Return current choice index.
 *
 * @param {Struct.Dialog} dialog
 */
function dialog_get_choice(dialog) {
	return dialog.choice;
}

/**
 * Return array of choices text.
 *
 * @param {Struct.Dialog} dialog
 */
function dialog_get_choices_text(dialog) {
	var result = [];
	with (dialog) {
		var choices = get_current_step().choices;
		for (var i = 0; i < array_length(choices); i++) {
			var text = get_current_step().choices[i].text;
			if (array_length(text) > 0) array_push(result, text[language_index]);
		}
		return result;
	}
}

/**
 * Set choice index.
 *
 * @param {Struct.Dialog} dialog The Dialog instance to set the choice of.
 * @param {real} choice_index New index to set current choice to. Value is clamped to valid options for the current step.
 */
function dialog_set_choice(dialog, choice_index) {
	with (dialog) {
		choice = clamp(choice_index, 0, array_length(get_current_step().choices) - 1);
	}
}

/**
 * Increment choice index. Value does not increase past number of choices or wrap.
 *
 * @param {Struct.Dialog} dialog The Dialog instance to increment the choice of.
 */
function dialog_choice_increment(dialog) {
	with (dialog) {
		choice = clamp(choice + 1, 0, array_length(get_current_step().choices) - 1);
	}
}

/**
 * Decrement choice index. Value does not Decrease below 0 or wrap.
 *
 * @param {Struct.Dialog} dialog The Dialog instance to decrement the choice of.
 */
function dialog_choice_decrement(dialog) {
	with (dialog) {
		choice = clamp(choice - 1, 0, array_length(get_current_step().choices) - 1);
	}
}

/**
 * Advances dialog to next step. The next step is decided by the current choice index.
 *
 * @param {Struct.Dialog} dialog
 */
function dialog_advance(dialog) {
	with (dialog) {
		var step = get_current_step();
		if (array_length(step.choices) <= 0) return;
		current_step_name = step.choices[choice].goto;
		choice = 0;
	}
}

/**
 * Indicates if the current step is an end of the dialog (there could be more than one).
 *
 * @param {Struct.Dialog} dialog
 */
function dialog_is_at_end(dialog) {
	with (dialog) {
		return array_length(get_current_step().choices) == 0;
	}
}