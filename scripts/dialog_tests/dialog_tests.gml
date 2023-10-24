/**
 * Given two arrays of strings, ensure they're the same.
 */
function __dialog_text_compare(a, b, step_index) {
	if (!is_array(a)) show_error($"dialog step {step_index} text compare a is not an array", true);
	if (!is_array(b)) show_error($"dialog step {step_index} text compare b is not an array", true);
	if (array_length(a) != array_length(b)) show_error($"dialog step {step_index} text compare arrays a and b have different sizes", true);
	for (var t = 0; t < array_length(a); t++) {
		var text_a = a[t];
		var text_b = b[t];
		if (!is_string(text_a)) show_error($"dialog step {step_index} text a at {t} is not a string", true);
		if (!is_string(text_b)) show_error($"dialog step {step_index} text b at {t} is not a string", true);
		if (text_a != text_b) show_error($"dialog step {step_index} text a and b {t} are not the same", true);
	}
}

/**
 * Given two arrays of dialog objects, ensure that they're the same.
 */
function __dialog_compare(a, b) {
	if (!is_array(a)) show_error("dialog a is not an array", true);
	if (!is_array(b)) show_error("dialog b is not an array", true);
	if (array_length(a) != array_length(b)) show_error("dialog a and b are not the same length", true);
	for (var i = 0; i < array_length(a); i++ ) {
		var step_a = a[i];
		var step_b = b[i];
		if (!is_struct(step_a)) show_error($"dialog a step {i} is not a struct", true);
		if (!is_struct(step_b)) show_error($"dialog b step {i} is not a struct", true);
		
		if (!variable_struct_exists(step_a, "name")) show_error($"dialog a step {i} is missing name field", true);
		if (!variable_struct_exists(step_a, "text")) show_error($"dialog a step {i} is missing text field", true);
		if (!variable_struct_exists(step_a, "choices")) show_error($"dialog a step {i} is missing choices field", true);
		
		if (!variable_struct_exists(step_b, "name")) show_error($"dialog b step {i} is missing name field", true);
		if (!variable_struct_exists(step_b, "text")) show_error($"dialog b step {i} is missing text field", true);
		if (!variable_struct_exists(step_b, "choices")) show_error($"dialog b step {i} is missing choices field", true);
		
		if (!is_string(step_a.name)) show_error($"dialog a step {i} name field is not a string", true);
		if (!is_array(step_a.text)) show_error($"dialog a step {i} text field is not an array", true);
		if (!is_array(step_a.choices)) show_error($"dialog a step {i} choices field is not an array", true);
		
		if (!is_string(step_b.name)) show_error($"dialog b step {i} name field is not a string", true);
		if (!is_array(step_b.text)) show_error($"dialog b step {i} text field is not an array", true);
		if (!is_array(step_b.choices)) show_error($"dialog b step {i} choices field is not an array", true);
		
		if (step_a.name != step_b.name) show_error($"dialog step {i} a and b have different names", true);
		
		// check text
		__dialog_text_compare(step_a.text, step_b.text, i);
		
		// check choices
		if (array_length(step_a.choices) != array_length(step_b.choices)) show_error($"dialog step {i} choices array are not the same length", true);
		for (var c = 0; c < array_length(step_a.choices); c++) {
			var choice_a = step_a.choices[c];
			var choice_b = step_b.choices[c];
			if (!is_struct(choice_a)) show_error($"dialog a step {i} choice {c} is not a struct", true);
			if (!is_struct(choice_b)) show_error($"dialog b step {i} choice {c} is not a struct", true);
			if (!variable_struct_exists(choice_a, "text")) show_error($"dialog a step {i} choice {c} is missing text field", true);
			if (!variable_struct_exists(choice_a, "goto")) show_error($"dialog a step {i} choice {c} is missing goto field", true);
			if (!variable_struct_exists(choice_b, "text")) show_error($"dialog b step {i} choice {c} is missing text field", true);
			if (!variable_struct_exists(choice_b, "goto")) show_error($"dialog b step {i} choice {c} is missing goto field", true);
			__dialog_text_compare(choice_a.text, choice_b.text, i);
			if (!is_string(choice_a.goto)) show_error($"dialog a step {i} choice {c} goto is not a string", true);
			if (!is_string(choice_b.goto)) show_error($"dialog b step {i} choice {c} goto is not a string", true);
			if (choice_a.goto != choice_b.goto) show_error($"dialog step {i} choice {c} a and b have different goto", true);
		}
		
		// data
		if (!variable_struct_exists(step_a, "data")) show_error($"dialog a step {i} is missing data field", true);
		if (!variable_struct_exists(step_b, "data")) show_error($"dialog b step {i} is missing data field", true);
		if (typeof(step_a.data) != typeof(step_b.data)) show_error($"dialog step {i} a and b have different data type", true);
	}
}

function __dialog_test_string_shortcut() {
	show_debug_message("dialog testing string shorthand");
	var expected_result = [
		{
			name: "auto_0",
			text: [
				"Hello!",
			],
			choices: [
				{
					text: [],
					goto: "auto_1",
				}
			],
			data: undefined,
		},
		{
			name: "auto_1",
			text: [
				"Welcome to the game.",
			],
			choices: [
				{
					text: [],
					goto: "auto_2",
				}
			],
			data: undefined,
		},
		{
			name: "auto_2",
			text: [
				"Don't let the monsters get you.",
			],
			choices: [
				{
					text: [],
					goto: "auto_3",
				}
			],
			data: undefined,
		},
		{
			name: "auto_3",
			text: [
				"Goodbye for now.",
			],
			choices: [],
			data: undefined,
		},
	];
	var test = new Dialog(["Hello!", "Welcome to the game.", "Don't let the monsters get you.", "Goodbye for now."]).dialog_steps;
	__dialog_compare(test, expected_result);
}

function __dialog_test_lang_shortcut() {
	show_debug_message("dialog testing array shorthand");
	var expected_result = [
		{
			name: "auto_0",
			text: [
				"Hello!",
				"こんにちは",
				"¡Hola!",
			],
			choices: [
				{
					text: [],
					goto: "auto_1",
				}
			],
			data: undefined,
		},
		{
			name: "auto_1",
			text: [
				"Welcome to the game.",
				"ゲームへようこそ。",
				"Bienvenida al juego.",
			],
			choices: [
				{
					text: [],
					goto: "auto_2",
				}
			],
			data: undefined,
		},
		{
			name: "auto_2",
			text: [
				"Don't let the monsters get you.",
				"モンスターに騙されないようにしましょう。",
				"No dejes que los monstruos te atrapen.",
			],
			choices: [
				{
					text: [],
					goto: "auto_3",
				}
			],
			data: undefined,
		},
		{
			name: "auto_3",
			text: [
				"Goodbye for now.",
				"とりあえずさようなら。",
				"Adiós por ahora.",
			],
			choices: [],
			data: undefined,
		},
	];
	var test = new Dialog([
		[
			"Hello!",
			"こんにちは",
			"¡Hola!",
		],
		[
			"Welcome to the game.",
			"ゲームへようこそ。",
			"Bienvenida al juego.",
		],
		[
			"Don't let the monsters get you.",
			"モンスターに騙されないようにしましょう。",
			"No dejes que los monstruos te atrapen.",
		],
		[
			"Goodbye for now.",
			"とりあえずさようなら。",
			"Adiós por ahora.",
		],
	]).dialog_steps;
	__dialog_compare(test, expected_result);
}

function __dialog_test_branching() {
	show_debug_message("dialog testing branching");
	var test = new Dialog([
		["Hello!", "¡Hola!"],
		{
			text: ["Make your choice...", "Haz tu elección..."],
			choices: [
				{ text: ["One", "Uno"], goto: "one" },
				{ text: ["Two", "Dos"], goto: "two" },
			]
		},
		{
			name: "one",
			text: ["You've chosen One.", "Has elegido Uno."],
			choices: [
				{ text: [], goto: "end" }
			],
		},
				{
			name: "two",
			text: ["You've chosen Two.", "Has elegido Dos."],
			choices: [
				{ text: [], goto: "end" }
			],
		},
		{
			name: "end",
			text: ["This is the end of the dialog.", "Este es el final del diálogo."],
		},
	]);
	var expected_result = [
		{
			name: "auto_0",
			text: ["Hello!", "¡Hola!"],
			choices: [
				{
					text: [],
					goto: "auto_1",
				}
			],
			data: undefined,
		},
		{
			name: "auto_1",
			text: ["Make your choice...", "Haz tu elección..."],
			choices: [
				{ text: ["One", "Uno"], goto: "one" },
				{ text: ["Two", "Dos"], goto: "two" },
			],
			data: undefined,
		},
		{
			name: "one",
			text: ["You've chosen One.", "Has elegido Uno."],
			choices: [
				{ text: [], goto: "end" }
			],
			data: undefined,
		},
		{
			name: "two",
			text: ["You've chosen Two.", "Has elegido Dos."],
			choices: [
				{ text: [], goto: "end" }
			],
			data: undefined
		},
		{
			name: "end",
			text: ["This is the end of the dialog.", "Este es el final del diálogo."],
			choices: [],
			data: undefined,
		},
	];
	dialog_advance(test);
	dialog_choice_increment(test);
	dialog_choice_increment(test);
	dialog_choice_increment(test);
	dialog_choice_increment(test); // too many calls should not break
	dialog_advance(test);
	if (dialog_get_text(test) != "You've chosen Two.") show_error("Dialog branch should've gone to Two.", true);
	dialog_advance(test);
	if (dialog_get_text(test) != "This is the end of the dialog.") show_error("Dialog branch text should be end.", true);
	__dialog_compare(test.dialog_steps, expected_result);
}

function __dialog_test_wrong_lang_num() {
	show_debug_message("dialog testing language count check");
	var error_thrown = false;
	try {
		var test = new Dialog([
			[
				"Hello!",
				"こんにちは",
				"¡Hola!",
			],
			[
				"Welcome to the game.",
				"Bienvenida al juego.",
			],
			[
				"Don't let the monsters get you.",
				"モンスターに騙されないようにしましょう。",
			],
			[
				"Adiós por ahora.",
			],
		]);
	} catch (error) {
		if (error != undefined) error_thrown = true;
	}
	if (!error_thrown) show_error($"Dialog was created with inconsistent number of languages in text. This should not be possible.", true);
	error_thrown = false;
	try {
		var test = new Dialog([
			{
				text: [
					"Choose A or B.",
				],
				choices: [
					{
						text: [
							"choose A",
							"choose A other language",
						],
						goto: "A",
					},
					{
						text: [
							"choose B",
						],
						goto: "B",
					},
				],
			},
			{
				name: "A",
				text: [
					"You chose A!"
				],
				choices: [
					{
						text: [],
						goto: "end",
					}
				],
			},
			{
				name: "B",
				text: [
					"You chose B!"
				],
				choices: [
					{
						text: [],
						goto: "end",
					}
				],
			},
			{
				name: "end",
				text: [
					"it's the end",
				]
			}
		]);
	} catch (error) {
		if (error != undefined) error_thrown = true;
	}
	if (!error_thrown) show_error($"Dialog was created with inconsistent number of languages in choices. This should not be possible.", true);
}

function __dialog_tests() {
	__dialog_test_string_shortcut();
	__dialog_test_lang_shortcut();
	__dialog_test_branching();
	__dialog_test_wrong_lang_num();
}

__dialog_tests();
