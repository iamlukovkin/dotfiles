local colors = require("colors")
local settings = require("settings")

Bar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = Bar.add("item", "widgets.cpu", 42, {
	position = "right",
	icon = {
		string = "􀫥",
	},
	label = {
		string = "??%",
		align = "right",
	},
})

cpu:subscribe("cpu_update", function(env)
	cpu:set({
		label = env.total_load .. "%",
	})
end)

cpu:subscribe("mouse.clicked", function()
	Bar.exec("open -a 'Activity Monitor'")
end)
