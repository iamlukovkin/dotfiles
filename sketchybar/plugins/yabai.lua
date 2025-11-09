function GetSpacesCount()
	local req = io.popen("yabai -m query --spaces | jq '.[].id'")
	if not req then
		return 0
	end
	local response = req:read("*a")
	req:close()
	local count = 0
	for _ in response:gmatch("[^\r\n]+") do
		count = count + 1
	end
	return count
end

function GetCurrentWorkspace()
	local req = io.popen("yabai -m query --spaces --space")
	if not req then
		return nil
	end
	local resp = req:read("*a")
	req:close()
	local index = resp:match('"index"%s*:%s*(%d+)')
	if index then
		return tonumber(index)
	else
		return nil
	end
end

function GetCurrentDisplay()
	local req = io.popen("yabai -m query --displays --display")
	if not req then
		return nil
	end
	local resp = req:read("*a")
	req:close()
	local index = resp:match('"index"%s*:%s*(%d+)')
	if index then
		return tonumber(index)
	else
		return nil
	end
end

function GetAppsOnWorkspace(space_id)
	local req = io.popen("yabai -m query --windows --space " .. space_id)
	if not req then
		return {}
	end
	local resp = req:read("*a")
	req:close()
	local all_apps = {}
	for app in resp:gmatch('"app"%s*:%s*"([^"]+)"') do
		all_apps[app] = true
	end
	local unique_apps = {}
	for app, _ in pairs(all_apps) do
		table.insert(unique_apps, app)
	end
	return unique_apps
end
