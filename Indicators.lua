local refs = {
	Ragebot = {ref = {ui.reference("Rage", "Aimbot", "Enabled")}, name = 'Ragebot'},
	Multipoint = {ref = {ui.reference("Rage", "Aimbot", "Multi-point")}, name = 'Multi-point'},
	SafePoint = {ref = {ui.reference("Rage", "Aimbot", "Force safe point")}, name = 'Force safe point'},
	QuickStop = {ref = {ui.reference("Rage", "Other", "Quick stop")}, name = 'Quick stop'},
	AaCorrectionOverride = {ref = {ui.reference("Rage", "Other", "Anti-aim correction override")},  name = 'Anti-aim correction override'},
	ForceBaim = {ref = {ui.reference("Rage", "Other", "Force body aim")}, name = 'Force body aim'},
	Fakeduck = {ref = {ui.reference("Rage", "Other", "Duck peek assist")}, name = 'Duck peek assist'},
	Doubletap = {ref = {ui.reference("Rage", "Other", "Double tap")}, name = 'Double tap'},
	AA = {ref = {ui.reference("AA", "Anti-aimbot angles", "Enabled")}, name = 'Anti-aim'},
	Fakelag = {ref = {ui.reference("AA", "Fake lag", "Enabled")},  name = 'Fake lag'},
	SlowWalk = {ref = {ui.reference("AA", "Other", "Slow motion")}, name = 'Slow motion'},
	OnShotAa = {ref = {ui.reference("AA", "Other", "On shot anti-aim")}, name = 'Anti-aim'},
	Visuals = {ref = {ui.reference("Visuals", "Player ESP", "Activation type")}, name = 'ESP'},
	SharedESP = {ref = {ui.reference("Visuals", "Other ESP", "Shared ESP")}, name = 'Shared ESP'},
	Thirdperson = {ref = {ui.reference("Visuals", "Effects", "Force third person (alive)")}, name = 'Force third person (alive)}'},
	AutoGrenade = {ref = {ui.reference("Misc", "Miscellaneous", "Automatic grenade release")}, name = 'Automatic grenade release'},
	PingSpike = {ref = {ui.reference("Misc", "Miscellaneous", "Ping Spike")}, name = 'Ping spike'},
	FreeLook = {ref = {ui.reference("Misc", "Miscellaneous", "Free look")}, name = 'Free look'},
	LastSecondDefuse = {ref = {ui.reference("Misc", "Miscellaneous", "Last second defuse")}, name = 'Last second defuse'},
	Blockbot = {ref = {ui.reference("Misc", "Movement", "Blockbot")}, name = 'Blockbot'},
	EdgeJump = {ref = {ui.reference("Misc", "Movement", "Jump at edge")}, name = 'Jump at edge'},
	Menu = {ref = {ui.reference("Misc", "Settings", "Menu key")}, name = 'Menu'}
}

local get_name = function(tbl)
	local v, N = {}, 1

	for key, val in pairs(tbl) do
		v[N] = val['name']
		N = N + 1
	end

	return v
end

local indicators = ui.new_multiselect("Lua", "B", "Indicators", get_name(refs))

ui.new_label("Lua", "B", "Enabled color")
local enabled_color = ui.new_color_picker("Lua", "B", "Enable color", 0, 255, 0, 255)

ui.new_label("Lua", "B", "Disabled color")
local disabled_color = ui.new_color_picker("Lua", "B", "Disable color", 255, 0, 0, 255)

local size = ui.new_combobox("Lua", "B", "Size", "Normal", "Small", "Large")
local alignment = ui.new_combobox("Lua", "B", "Alignment", "Left", "Right", "Center")
local w, h = client.screen_size()
local pos_x = ui.new_slider("Lua", "B", "Location X", 0, w, w / 2, true)
local pos_y = ui.new_slider("Lua", "B", "Location Y", 0, h, h / 2, true)

local contains = function(tbl, val)
	for i=1, #tbl do
		if tbl[i] == val then
			return true
		end
	end

	return false
end

local get, text, measure_text = ui.get, renderer.text, renderer.measure_text
local function on_paint()
	local r, g, b, a = 0, 0, 0, 0
	local x, y = get(pos_x), get(pos_y)
	local eR, eG, eB, eA = get(enabled_color)
	local dR, dG, dB, dA = get(disabled_color)
	local inds = get(indicators)
	local N = 0

	local s = get(size)
	local s = (s == 'Normal' and '') or (s == 'Small' and '-') or (s == 'Large' and '+')
	local al = get(alignment)
	local flag = (al == "Left" and '') or (al == "Center" and 'c') or (al == 'Right' and 'r')
	local flag = flag.. s

	for key, value in pairs(refs) do
		if contains(inds, value.name) then
			local tW, tH = measure_text(flag, key)
			local checkbox, hotkey = value.ref[1], value.ref[2]

			if checkbox ~= nil and hotkey ~= nil then
				if get(checkbox) and get(hotkey) then
					r, g, b, a = eR, eG, eB, eA
				else
					r, g, b, a = dR, dG, dB, dA
				end

			elseif checkbox == nil and hotkey ~= nil then
				if get(hotkey) then
					r, g, b, a = eR, eG, eB, eA
				else
					r, g, b, a = dR, dG, dB, dA
				end

			elseif checkbox ~= nil and hotkey == nil then
				if get(checkbox) then
					r, g, b, a = eR, eG, eB, eA
				else
					r, g, b, a = dR, dG, dB, dA
				end
			end

			text(x, y + (N * tH), r, g, b, a, flag, 0, key) -- value.name
			N = N + 1
		end
	end
end

client.set_event_callback('paint', on_paint)
