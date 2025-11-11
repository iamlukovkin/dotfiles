local item = Bar.add("item", "calendar", {
	position = "right",
	icon = { string = "􀧞" },
	update_freq = 30,
})

item:subscribe({ "forced", "routine", "system_woke" }, function()
	item:set({ label = { string = os.date("%a %d %b %I:%M %p") } })
end)
