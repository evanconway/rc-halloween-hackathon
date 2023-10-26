interact_set_dialog_and_invisible([
	"I'm a pumpkin.",
	"Unlike the other decorations, I've become self-aware.",
	{
		text: "Am I spooky?",
		choices: [
			{
				text: "yes",
				goto: "y"
			},
			{
				text: "no",
				goto: "n"
			}
		]
	},
	{
		name: "y",
		text: "Thank you for affirming my spookiness.",
		choices: []
	},
	{
		name: "n",
		text: "Wait till next year..."
	},
	"I'll scare the pants off of you!"
]);
