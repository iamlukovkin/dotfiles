local app_icons = require("helpers.app_icons")

local spaces = {}

local workspaces_count = GetSpacesCount()
local current_workspace = GetCurrentWorkspace()

local function get_space_icons(apps)
	local icons = ""
	local no_app = true
	for _, app in ipairs(apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["default"] or lookup)
		icons = icons .. " " .. icon
	end
	if no_app then
		icons = " —"
	end
	return icons
end

local function change_space_icons(space_idx, apps)
	Bar.animate("tanh", 10, function()
		spaces[space_idx]:set({
			label = get_space_icons(apps),
		})
	end)
end

local function change_space_highlight(new_space)
	for idx, space in ipairs(spaces) do
		local is_active = (idx == new_space)
		space:set({
			icon = {
				highlight = is_active,
			},
			label = {
				highlight = is_active,
			},
		})
	end
end

for i = 1, workspaces_count, 1 do
	local space = Bar.add("item", "item." .. i, {
		position = "center",
		icon = {
			font = {
				family = "FiraCode Nerd Font Mono",
			},
			string = i,
			padding_left = 12,
			padding_right = 6,
			color = Schema.inactive,
			highlight_color = Schema.active,
		},
		label = {
			padding_right = 16,
			color = Schema.inactive,
			highlight_color = Schema.active,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
		},
		padding_right = 0,
		padding_left = 0,
	})

	spaces[i] = space
	local apps = GetAppsOnWorkspace(i)
	change_space_highlight(current_workspace)
	change_space_icons(i, apps)

	Bar.add("item", "item." .. i .. "padding", {
		script = "",
		width = 4,
	})

	space:subscribe("space_change", function(env)
		for _, new_space in pairs(env.INFO) do
			change_space_highlight(new_space)
		end
	end)
end

local space_window_observer = Bar.add("item", {
	drawing = false,
	updates = true,
})

space_window_observer:subscribe("space_windows_change", function(env)
	local apps = {}
	local idx = 1
	for app_name, _ in pairs(env.INFO.apps) do
		apps[idx] = app_name
		idx = idx + 1
	end
	change_space_icons(env.INFO.space, apps)
end)
