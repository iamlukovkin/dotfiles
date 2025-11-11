local function get_spaces_count()
	local req = io.popen("yabai -m query --spaces | jq 'length'")
	if not req then
		return 0
	end
	local result = req:read("*a")
	req:close()
	return result
end

local function handle_space_change(env)
	local is_selected = env.SELECTED == "true"
	local text_color = (is_selected and Colors.bar_color_solid) or Colors.accent_color
	local background_color = (is_selected and Colors.accent_color) or Colors.transparent
	Bar.set(env.NAME, {
		background = { drawing = is_selected, color = background_color },
		label = { color = text_color },
		icon = { color = text_color },
	})
end

local spaces_count = get_spaces_count()
for sid = 1, spaces_count, 1 do
	local space = Bar.add("space", "space." .. sid, {
		position = "center",
		space = sid,
		padding_right = 0,
		padding_left = 0,
		icon = {
			string = sid,
			padding_right = 0,
		},
		label = {
			font = "sketchybar-app-font:Regular:16.0",
			padding_right = 16,
			y_offset = -1,
		},
		background = {
			color = Colors.item_bg_color,
		},
	})
	space:subscribe("space_change", handle_space_change)
end

Bar.add("bracket", { "/space\\..*/" }, {
	position = "center",
	background = {
		color = Colors.transparent,
		border_width = 1,
		border_color = Colors.white,
	},
})

local space_separator = Bar.add("item", "space_separator", {
	drawing = false,
})

space_separator:subscribe("space_windows_change", function(env)
	local space = env.INFO.space
	local icons = ""
	local apps_exists = false
	for app, _ in pairs(env.INFO.apps) do
		apps_exists = true
		icons = icons .. " " .. GetIcon(app)
	end
	if not apps_exists then
		icons = " —"
	end
	Bar.set("space." .. space, { label = { string = icons } })
end)
