dialog_data = [
	"I love programming.",
	{
		text: "Do you love programming?",
		choices: [
			{
				text: "yes",
				goto: "y"
			},
			{
				text: "yup",
				goto: "y"
			},
			{
				text: "ya",
				goto: "y"
			}
		]
		
	},
	{
		name: "y",
		text: "Me too!"
	}
];