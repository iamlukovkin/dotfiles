Bar.add("item", "media_art", {
	position = "left",
	padding_right = 0,
	padding_left = 8,
	background = {
		image = {
			string = "media.artwork",
			scale = 0.66,
			corner_radius = 8,
		},
		color = Colors.transparent,
	},
	label = { drawing = false },
	icon = { drawing = false },
	drawing = false,
	width = "dynamic",
	updates = true,
})

Bar.add("item", "media_artist", {
	position = "left",
	scroll_texts = true,
	padding_right = 2,
	label = {
		font = {
			size = 8,
		},
		color = Colors.white,
		max_chars = 24,
		padding_left = 0,
	},
	y_offset = 6,
	icon = { drawing = false },
	width = 0,
	background = { drawing = false },
})

Bar.add("item", "media_title", {
	position = "left",
	scroll_texts = true,
	label = {
		font = {
			size = 12,
		},
		color = Colors.white,
		max_chars = 24,
		padding_left = 0,
	},
	y_offset = -4,
	icon = { drawing = false },
	width = 0,
	background = { drawing = false },
})

local br = Bar.add("bracket", { "/media_\\.*/" }, {
	position = "center",
	background = {
		color = Colors.transparent,
	},
})

Bar.subscribe("media_art", "media_change", function(env)
	local is_playing = (env.INFO.state == "playing")
	Bar.set("media_artist", {
		label = {
			string = (is_playing and env.INFO.artist or ""),
			drawing = is_playing,
		},
	})
	Bar.set("media_title", {
		label = {
			string = (is_playing and env.INFO.title or ""),
			drawing = is_playing,
		},
	})
	Bar.set("media_art", { drawing = is_playing })
end)
