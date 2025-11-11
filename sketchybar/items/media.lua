local media = Bar.add("item", "media", {
	position = "center",
	scroll_texts = true,
	label = {
		color = Colors.accent_color,
		max_chars = 32,
	},
	icon = {
		padding_left = 0,
		string = "􀑪",
		color = Colors.accent_color,
	},
	background = { drawing = false },
})

media:subscribe("media_change", function(env)
	local is_playing = (env.INFO.state == "playing")
	Bar.set(env.NAME, {
		label = {
			string = (is_playing and (env.INFO.title .. " - " .. env.INFO.artist) or ""),
			drawing = is_playing,
		},
	})
end)
