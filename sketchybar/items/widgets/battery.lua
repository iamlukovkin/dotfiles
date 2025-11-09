local battery_icon = {
	_100 = "􀛨",
	_75 = "􀺸",
	_50 = "􀺶",
	_25 = "􀛩",
	_0 = "􀛪",
	charging = "􀢋",
}

Battery = Bar.add("item", "widgets.battery", {
	position = "right",
	update_freq = 180,
	popup = {
		align = "center",
	},
})

Battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	Bar.exec("pmset -g batt", function(batt_info)
		local icon = "!"
		local label = "?"

		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			charge = tonumber(charge)
			label = charge .. "%"
		end

		local charging, _, _ = batt_info:find("AC Power")

		if charging then
			icon = battery_icon.charging
		else
			if found and charge > 80 then
				icon = battery_icon.battery._100
			elseif found and charge > 60 then
				icon = battery_icon.battery._75
			elseif found and charge > 40 then
				icon = battery_icon.battery._50
			elseif found and charge > 20 then
				icon = battery_icon.battery._25
			else
				icon = battery_icon.battery._0
			end
		end

		local lead = ""
		if found and charge < 10 then
			lead = "0"
		end

		Battery:set({
			icon = {
				string = icon,
			},
			label = {
				string = lead .. label,
			},
		})
	end)
end)
