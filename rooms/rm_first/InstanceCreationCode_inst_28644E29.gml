dialog_data = [
	"I have unique dialog.",
	{
		text: "Choose your path.",
		choices: [
			{
				text: "Left",
				goto: "left"
			},
			{
				text: "Right",
				goto: "right"
			}
		]
	},
	{
		name: "left",
		text: "You've chosen the Left path.",
		choices: [
			{
				text: [],
				goto: "after"
			}
		]
	},
	{
		name: "right",
		text: "You've chosen the Right path.",
		choices: [
			{
				text: [],
				goto: "after"
			}
		]
	},
	{
		name: "after",
		text: "May your travels bring you great fortune."
	},
	"Goodbye."
];