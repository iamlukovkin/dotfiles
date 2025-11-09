Apple = Bar.add("item", {
	icon = {
		y_offset = 2,
		font = {
			size = 24.0,
		},
		string = Icons.apple,
	},
	label = {
		drawing = false,
	},

	padding_left = 4,
	padding_right = 4,
	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})
