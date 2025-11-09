local background_opacity = 0.88

local alpha = math.floor(background_opacity * 255 + 0.5)

Bar.bar({
	color = string.format("0x%08X", (alpha << 24) | (Schema.black & 0x00FFFFFF)),
	border_color = Schema.white,
	border_width = 2,
	position = "top",
	height = 32,
	notch_display_height = 0,
	margin = 12,
	y_offset = 12,
	blur_radius = 20,
	corner_radius = 10,
	padding_left = 8,
	padding_right = 8,
	display = "all",
	hidden = false,
	topmost = false,
	sticky = true,
	font_smoothing = true,
	shadow = true,
})
