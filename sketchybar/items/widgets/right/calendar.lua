Bar.add("item", "calendar_date", {
	position = "right",
	icon = { drawing = false },
	label = {
		string = "day",
		font = {
			size = 8,
		},
		color = Colors.bar_color_solid,
	},
	width = 0,
	padding_left = 0,
	y_offset = 5,
})

Bar.add("item", "calendar_time", {
	position = "right",
	icon = { drawing = false },
	label = {
		string = "time",
		font = {
			size = 10,
		},
		color = Colors.bar_color_solid,
	},
	y_offset = -3,
	padding_left = 0,
})

Bar.add("item", "calendar_logo", {
	position = "right",
	icon = {
		string = "􀧞",
		padding_left = 2,
		padding_right = 0,
		color = Colors.bar_color_solid,
	},
	label = { drawing = false },
	padding_right = 0,
})

Bar.add("bracket", { "/calendar_\\.*/" }, {
	position = "center",
	width = 120,
	background = {
		color = Colors.accent_color,
	},
})

Bar.subscribe("calendar_logo", { "forced", "routine", "system_woke" }, function()
	Bar.set("calendar_date", { label = { string = os.date("%a %d %b") } })
	Bar.set("calendar_time", { label = { string = os.date("%I:%M %p") } })
end)
