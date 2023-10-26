dialog_data = [
	"If you could make you're own programming language...",
	{
		text: "Would you make it typed or dynamic?",
		choices: [
			{
				text: "Typed",
				goto: "t"
			},
			{
				text: "Dynamic",
				goto: "d"
			},
		]
	}, 
	{
		name: "t",
		text: "It's definitely easier to stay organized that way.",
		choices: [],
	},
	{
		name: "d",
		text: "Keeping things flexible let's you move faster!",
		choices: [],
	},
];
