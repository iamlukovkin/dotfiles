local current_app = {
	count = 0,
	items = {},
}

local menu_watcher = Bar.add("item", {
	drawing = false,
	updates = true,
})

local function create_card(title, idx)
	Bar.add("item", "menu." .. idx, {
		label = title,
		click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s " .. idx,
		padding_left = 0,
		padding_right = 0,
	})
end

menu_watcher:subscribe("front_app_switched", function()
	for i = 1, current_app.count, 1 do
		Bar.remove("menu." .. i)
	end
	current_app.items = {}
	current_app.count = 0
	Bar.exec("$CONFIG_DIR/helpers/menus/bin/menus -l", function(menus)
		local count = 0
		for menu in string.gmatch(menus, "[^\r\n]+") do
			count = count + 1
			current_app.items[count] = create_card(menu, count)
		end
		current_app.count = count
	end)
end)
