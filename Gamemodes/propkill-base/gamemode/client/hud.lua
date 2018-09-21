surface.CreateFont( "stb24", {
	font = "Trebuchet24",
	size = 24,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )
surface.CreateFont( "ltb24", {
	font = "Trebuchet24",
	size = 64,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

surface.CreateFont( "spec_font1", {
	font = "Default",
	size = 64,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "spec_font2", {
	font = "Default",
	size = 16,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "esp_font", {
	font = "CloseCaption_Bold",
	size = 12,
	weight = 550,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function PKHUD()
	local leader = GetGlobalString("PK_CurrentLeader", "Nobody")
	--local duelscore = GetGlobalString("PK_DuelScore")
	draw.RoundedBox(3, 5, ScrH() - 35, 300, 33, Color(24, 24, 24, 150))
	draw.SimpleText("Leader: " .. leader, "stb24", 10, ScrH() - 30, Color(255, 255, 255, 200), 0, 0)
	
	if LocalPlayer():Team() == TEAM_UNASSIGNED and IsValid(LocalPlayer():GetObserverTarget()) then
		draw.RoundedBox(3, ScrW() - 305, ScrH() - 35, 300, 33, Color(24, 24, 24, 150))
		draw.SimpleText("Spectating: " .. tostring(LocalPlayer():GetObserverTarget():GetName()) , "stb24", ScrW() - 300, ScrH() - 30, Color(255, 255, 255, 200), 0, 0)
	end

	if LocalPlayer():Team() == TEAM_UNASSIGNED then
		local coolmode = GetGlobalString("PK_CurrentMode")
		draw.SimpleText(coolmode, "spec_font1", ScrW()/2, ScrH()/6, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText("Click to cycle players, right click to follow, reload to first person spectate", "spec_font2", ScrW()/2, ScrH()/7+10, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	if timer.Exists("hudmsg") then
		draw.SimpleText(hudmsg, "spec_font1", ScrW()/2, ScrH()/6, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	if GetGlobalBool("Warmup") then
		draw.SimpleText("Warm Up", "spec_font1", ScrW()/2, ScrH()/4, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end
hook.Add("HUDPaint", "PKHUD", PKHUD)

function GM:HUDShouldDraw( name )
	local Blocked = { "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudWeaponSelection" }
	if table.HasValue( Blocked, name ) then
		return false
	end
	return true
end
