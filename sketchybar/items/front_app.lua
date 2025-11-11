local app = Bar.add("item", "front_app", {
	position = "left",
	background = { color = Colors.accent_color },
	icon = {
		color = Colors.bar_color,
		font = "sketchybar-app-font:Regular:12.0",
	},
	label = { color = Colors.bar_color },
})

app:subscribe("front_app_switched", function(env)
	if not env.SENDER == "front_app_switched" then
		return
	end
	Bar.set(env.NAME, {
		label = { string = env.INFO },
		icon = GetIcon(env.INFO),
	})
end)
