------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--																																								--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	In order to change the names of each indicator all you have to do is change what is in the quotes below														--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	For example, if you want to change the fake duck indicator to say fake duck then you go to line 15 and change 												--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	"Duck peek assist" to "Fake duck" Do not change anything other than what is in the quotations or you may cause errors if you do not know what youre doing.	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--																																								--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Ragebot = "Ragebot"
local Multipoint = "Multi-point"
local SafePoint = "Force safe point"
local QuickStop = "Quick stop"
local AaCorrectionOverride = "Anti-aim correction override"
local ForceBaim = "Force body aim"
local Fakeduck = "Duck peek assist"
local Doubletap = "Double tap"
local Fakelag = "Fake lag"
local SlowWalk = "Slow motion"
local OnShotAa = "On shot anti-aim"
local Visuals = "ESP"
local SharedESP = "Shared ESP"
local Thirdperson = "Force third person (alive)"
local AutoGrenade = "Automatic grenade release"
local PingSpike = "Ping spike"
local FreeLook = "Free look"
local LastSecondDefuse = "Last second defuse"
local Blockbot = "Blockbot"
local EdgeJump = "Jump at edge"
local Menu = "Menu"

--DONT-CHANGE-ANYTHING-PAST-THIS-POINT-UNLESS-YOU-KNOW-WHAT-YOURE-DOING!------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local indicators = ui.new_multiselect("Lua", "B", "Indicators", Ragebot, Multipoint, SafePoint, QuickStop, AaCorrectionOverride, ForceBaim, Fakeduck, Doubletap, Fakelag, SlowWalk, OnShotAa, Visuals, SharedESP, Thirdperson, AutoGrenade, PingSpike, FreeLook, LastSecondDefuse, Blockbot, EdgeJump, Menu)
local enabled_color_label = ui.new_label("Lua", "B", "Enabled color")
local enabled_color = ui.new_color_picker("Lua", "B", "Enable color", 0, 255, 0, 255)
local disabled_color_label = ui.new_label("Lua", "B", "Disabled color")
local disabled_color = ui.new_color_picker("Lua", "B", "Disable color", 255, 0, 0, 255)
local alignment = ui.new_combobox("Lua", "B", "Alignment", "Left", "Right", "Center")
local w, h = client.screen_size()
local pos_x = ui.new_slider("Lua", "B", "Location X", 0, w, w / 2, true)
local pos_y = ui.new_slider("Lua", "B", "Location Y", 0, h, h / 2, true)

local ragebot_enable, ragebot_key = ui.reference("Rage", "Aimbot", "Enabled")
local multipoint, multipoint_key = ui.reference("Rage", "Aimbot", "Multi-point")
local force_safe_point = ui.reference("Rage", "Aimbot", "Force safe point")
local quickstop, quickstop_key = ui.reference("Rage", "Other", "Quick stop")
local antiaim_correction_override = ui.reference("Rage", "Other", "Anti-aim correction override")
local force_bodyaim = ui.reference("Rage", "Other", "Force body aim")
local duck_peek_assist = ui.reference("Rage", "Other", "Duck peek assist")
local doubletap, doubletap_key = ui.reference("Rage", "Other", "Double tap")
local antiaim_enable = ui.reference("AA", "Anti-aimbot angles", "Enabled")
local fakelag, fakelag_key = ui.reference("AA", "Fake lag", "Enabled")
local slowmotion, slowmotion_key = ui.reference("AA", "Other", "Slow motion")
local onshot, onshot_key = ui.reference("AA", "Other", "On shot anti-aim")
local esp = ui.reference("Visuals", "Player ESP", "Activation type")
local shared_esp, shared_esp_key = ui.reference("Visuals", "Other ESP", "Shared ESP")
local force_thirdperson, force_thirdperson_key = ui.reference("Visuals", "Effects", "Force third person (alive)")
local automatic_greanade_release, automatic_greanade_release_key = ui.reference("Misc", "Miscellaneous", "Automatic grenade release")
local ping_spike, ping_spike_key = ui.reference("Misc", "Miscellaneous", "Ping Spike")
local free_look = ui.reference("Misc", "Miscellaneous", "Free look")
local last_second_defuse = ui.reference("Misc", "Miscellaneous", "Last second defuse")
local blockbot, blockbot_key = ui.reference("Misc", "Movement", "Blockbot")
local edge_jump, edge_jump_key = ui.reference("Misc", "Movement", "Jump at edge")
local menu = ui.reference("Misc", "Settings", "Menu key")

local function contains(table, val)
	for i = 1, #table do
		if table[i] == val then
			return true
		end
	end

	return false
end

local function ragebot(ctx)
	local w, h = client.screen_size()
	local center_x, center_y = w / 2, h / 2
	local offset = -10

	local x, y = ui.get(pos_x), ui.get(pos_y)

	local er, eg, eb, ea = ui.get(enabled_color)
	local dr, dg, db, da = ui.get(disabled_color)

	if ui.get(alignment) == "Left" then
		flags = ""
	elseif ui.get(alignment) == "Center" then
		flags = "c"
	elseif ui.get(alignment) == "Right" then
		flags = "r"
	end

	if contains(ui.get(indicators), Ragebot) then
		offset = offset + 10

		if ui.get(ragebot_enable) and ui.get(ragebot_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Ragebot)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Ragebot)
		end
	end

	if contains(ui.get(indicators), Multipoint) then
		offset = offset + 10

		if (contains(ui.get(multipoint), "Head") or contains(ui.get(multipoint), "Chest") or contains(ui.get(multipoint), "Stomach") or contains(ui.get(multipoint), "Arms") or contains(ui.get(multipoint), "Legs") or contains(ui.get(multipoint), "Feet")) and ui.get(multipoint_key) and ui.get(ragebot_enable) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Multipoint)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Multipoint)
		end
	end

	if contains(ui.get(indicators), SafePoint) then
		offset = offset + 10

		if ui.get(ragebot_enable) and ui.get(force_safe_point) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, SafePoint)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, SafePoint)
		end
	end

	if contains(ui.get(indicators), QuickStop) then
		offset = offset + 10

		if ui.get(ragebot_enable) and ui.get(quickstop) and ui.get(quickstop_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, QuickStop)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, QuickStop)
		end
	end

	if contains(ui.get(indicators), AaCorrectionOverride) then
		offset = offset + 10

		if ui.get(ragebot_enable) and ui.get(antiaim_correction_override) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, AaCorrectionOverride)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, AaCorrectionOverride)
		end
	end

	if contains(ui.get(indicators), ForceBaim) then
		offset = offset + 10

		if ui.get(ragebot_enable) and ui.get(force_bodyaim) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, ForceBaim)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, ForceBaim)
		end
	end

	if contains(ui.get(indicators), Fakeduck) then
		offset = offset + 10

		if ui.get(ragebot_enable) and ui.get(duck_peek_assist) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Fakeduck)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Fakeduck)
		end
	end

	if contains(ui.get(indicators), Doubletap) then
		offset = offset + 10

		if ui.get(ragebot_enable) and ui.get(doubletap) and ui.get(doubletap_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Doubletap)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Doubletap)
		end
	end
end

client.set_event_callback("paint", ragebot)

local function antiaim(ctx)
	local w, h = client.screen_size()
	local center_x, center_y = w / 2, h / 2
	local offset = -10

	local x, y = ui.get(pos_x), ui.get(pos_y)

	local er, eg, eb, ea = ui.get(enabled_color)
	local dr, dg, db, da = ui.get(disabled_color)

	if ui.get(alignment) == "Left" then
		flags = ""
	elseif ui.get(alignment) == "Center" then
		flags = "c"
	elseif ui.get(alignment) == "Right" then
		flags = "r"
	end

	if contains(ui.get(indicators), Ragebot) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Multipoint) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), SafePoint) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), QuickStop) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), AaCorrectionOverride) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), ForceBaim) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Fakeduck) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Doubletap) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Fakelag) then
		offset = offset + 10

		if ui.get(fakelag) and ui.get(fakelag_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Fakelag)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Fakelag)
		end
	end

	if contains(ui.get(indicators), SlowWalk) then
		offset = offset + 10

		if ui.get(slowmotion) and ui.get(slowmotion_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, SlowWalk)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, SlowWalk)
		end
	end

	if contains(ui.get(indicators), OnShotAa) then
		offset = offset + 10

		if ui.get(antiaim_enable) and ui.get(onshot) and ui.get(onshot_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, OnShotAa)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, OnShotAa)
		end
	end
end

client.set_event_callback("paint", antiaim)

local function visuals(ctx)
	local w, h = client.screen_size()
	local center_x, center_y = w / 2, h / 2
	local offset = -10

	local x, y = ui.get(pos_x), ui.get(pos_y)

	local er, eg, eb, ea = ui.get(enabled_color)
	local dr, dg, db, da = ui.get(disabled_color)

	if ui.get(alignment) == "Left" then
		flags = ""
	elseif ui.get(alignment) == "Center" then
		flags = "c"
	elseif ui.get(alignment) == "Right" then
		flags = "r"
	end

	if contains(ui.get(indicators), Ragebot) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Multipoint) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), SafePoint) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), QuickStop) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), AaCorrectionOverride) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), ForceBaim) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Fakeduck) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Doubletap) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Fakelag) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), SlowWalk) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), OnShotAa) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Visuals) then
		offset = offset + 10

		if ui.get(esp) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Visuals)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Visuals)
		end
	end

	if contains(ui.get(indicators), SharedESP) then
		offset = offset + 10

		if ui.get(esp) and ui.get(shared_esp) and ui.get(shared_esp_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, SharedESP)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, SharedESP)
		end
	end

	if contains(ui.get(indicators), Thirdperson) then
		offset = offset + 10

		if ui.get(esp) and ui.get(force_thirdperson) and ui.get(force_thirdperson_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Thirdperson)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Thirdperson)
		end
	end
end

client.set_event_callback("paint", visuals)

local function misc(ctx)
	local w, h = client.screen_size()
	local center_x, center_y = w / 2, h / 2
	local offset = -10

	local x, y = ui.get(pos_x), ui.get(pos_y)

	local er, eg, eb, ea = ui.get(enabled_color)
	local dr, dg, db, da = ui.get(disabled_color)

	if ui.get(alignment) == "Left" then
		flags = ""
	elseif ui.get(alignment) == "Center" then
		flags = "c"
	elseif ui.get(alignment) == "Right" then
		flags = "r"
	end

	if contains(ui.get(indicators), Ragebot) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Multipoint) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), SafePoint) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), QuickStop) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), AaCorrectionOverride) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), ForceBaim) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Fakeduck) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Doubletap) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Fakelag) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), SlowWalk) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), OnShotAa) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Visuals) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), SharedESP) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), Thirdperson) then
		offset = offset + 10
	end

	if contains(ui.get(indicators), AutoGrenade) then
		offset = offset + 10

		if ui.get(automatic_greanade_release) and ui.get(automatic_greanade_release_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, AutoGrenade)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, AutoGrenade)
		end
	end

	if contains(ui.get(indicators), PingSpike) then
		offset = offset + 10

		if ui.get(ping_spike) and ui.get(ping_spike_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, PingSpike)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, PingSpike)
		end
	end

	if contains(ui.get(indicators), FreeLook) then
		offset = offset + 10

		if ui.get(free_look) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, FreeLook)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, FreeLook)
		end
	end

	if contains(ui.get(indicators), LastSecondDefuse) then
		offset = offset + 10

		if ui.get(last_second_defuse) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, LastSecondDefuse)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, LastSecondDefuse)
		end
	end

	if contains(ui.get(indicators), Blockbot) then
		offset = offset + 10

		if ui.get(blockbot) and ui.get(blockbot_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Blockbot)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Blockbot)
		end
	end

	if contains(ui.get(indicators), EdgeJump) then
		offset = offset + 10

		if ui.get(edge_jump) and ui.get(edge_jump_key) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, EdgeJump)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, EdgeJump)
		end
	end

	if contains(ui.get(indicators), Menu) then
		offset = offset + 10

		if ui.get(menu) then
			renderer.text(x, y + offset, er, eg, eb, ea, flags, 0, Menu)
		else
			renderer.text(x, y + offset, dr, dg, db, da, flags, 0, Menu)
		end
	end
end

client.set_event_callback("paint", misc)