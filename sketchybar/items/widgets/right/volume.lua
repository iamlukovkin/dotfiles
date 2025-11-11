local item = Bar.add("item", "volume", {
	position = "right",
	padding_left = 4,
	padding_right = 4,
	label = {
		padding_left = 4,
		padding_right = 4,
	},
	icon = {
		padding_left = 0,
	},
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
