local item = Bar.add("item", "cpu", {
	position = "right",
	update_freq = 2,
	icon = { string = "􀧓" },
})

item:subscribe("routine", function()
	local core_count_req = io.popen("sysctl -n machdep.cpu.thread_count")
	if not core_count_req then
		return
	end
	local core_count_str = core_count_req:read("*a")
	core_count_req:close()
	local core_count = tonumber(core_count_str:match("%d+")) or 1
	local cpu_info_req = io.popen("ps -eo pcpu,user")
	if not cpu_info_req then
		return
	end
	local cpu_info = cpu_info_req:read("*a")
	cpu_info_req:close()
	local current_user = os.getenv("USER") or ""
	local cpu_sys_sum = 0
	local cpu_user_sum = 0
	for line in cpu_info:gmatch("[^\r\n]+") do
		local pcpu, user = line:match("^%s*([%d.]+)%s+(%S+)")
		if pcpu and user then
			local cpu_value = tonumber(pcpu) or 0
			if user == current_user then
				cpu_user_sum = cpu_user_sum + cpu_value
			else
				cpu_sys_sum = cpu_sys_sum + cpu_value
			end
		end
	end
	local cpu_sys_percent = cpu_sys_sum / (100.0 * core_count)
	local cpu_user_percent = cpu_user_sum / (100.0 * core_count)
	local cpu_percent = math.floor((cpu_sys_percent + cpu_user_percent) * 100 + 0.5)
	Bar.set("cpu", { label = { string = cpu_percent .. "%" } })
end)
