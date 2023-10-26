interact_set_dialog_and_invisible([
	"You can check into RC on this computer.",
	{
		text: "Checkin now?",
		choices: [
			{
				text: "Yes",
				goto: "y"
			},
			{
				text: "No",
				goto: "n"
			}
		]
	},
	{
		name: "y",
		text: "You're all checked in!",
		choices: []
	},
	{
		name: "n",
		text: "You can checkin anytime later.",
		choices: []
	}
]);
