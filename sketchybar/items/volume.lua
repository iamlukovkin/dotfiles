local item = Bar.add("item", "volume", {
	position = "right",
})

item:subscribe("volume_change", function(env)
	local volume = tonumber(env.INFO)
	local icon = "􀊣"
	if volume > 60 then
		icon = "􀊩"
	elseif volume > 30 then
		icon = "􀊥"
	elseif volume > 0 then
		icon = "􀊡"
	end
	Bar.set(env.NAME, { icon = icon, label = volume .. "%" })
end)
