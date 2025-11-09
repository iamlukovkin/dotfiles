local settings = require("settings")
local colors = require("colors")

local cal = Bar.add("item", {
	label = {
		font = {
			family = settings.icons,
		},
	},
	position = "right",
	update_freq = 30,
})

local month_labels = {
	"jan",
	"feb",
	"mar",
	"apr",
	"may",
	"jun",
	"jul",
	"aug",
	"sep",
	"oct",
	"nov",
	"dec",
}

cal:subscribe({ "forced", "routine", "system_woke" }, function()
	local cur = os.date("*t")
	cal:set({
		label = string.format("%02d %s %02d:%02d", cur.day, month_labels[cur.month], cur.hour, cur.min),
	})
end)
