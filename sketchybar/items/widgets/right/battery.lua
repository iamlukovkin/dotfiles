local item = Bar.add("item", "battery", {
	position = "right",
	padding_left = 4,
	label = {
		padding_left = 4,
		padding_right = 4,
	},
	icon = {
		padding_left = 0,
	},
	padding_right = 4,
	update_freq = 120,
})

item:subscribe({ "system_woke", "power_source_change" }, function()
	local perc_req = io.popen('pmset -g batt | grep -Eo "\\d+%" | cut -d% -f1')
	local charg_req = io.popen("pmset -g batt | grep 'AC Power'")
	if (not perc_req) or not charg_req then
		return
	end
	local percentage = tonumber(perc_req:read("*a"))
	local is_charging = charg_req:read("*a")
	perc_req:close()
	charg_req:close()
	local icon = "􀛪"
	if percentage > 90 then
		icon = "􀛨"
	elseif percentage > 60 then
		icon = "􀺸"
	elseif percentage > 10 then
		icon = "􀛩"
	end
	if is_charging == "" then
		icon = "􀢋"
	end
	item:set({ icon = { string = icon }, label = { string = percentage .. "%" } })
end)
