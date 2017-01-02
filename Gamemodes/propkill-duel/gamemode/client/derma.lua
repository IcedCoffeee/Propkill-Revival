/*------------------------------------------
			Propkill Derma Script
------------------------------------------*/ 

/*------------------------------------------
					Fonts
------------------------------------------*/  
surface.CreateFont( "team_font", {
	font = "Trebuchet24",
	size = 32,
	weight = 650,
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

surface.CreateFont( "menu_header_font", {
	font = "Trebuchet24",
	size = 48,
	weight = 650,
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

surface.CreateFont( "menu_subheader_font", {
	font = "Trebuchet24",
	size = 32,
	weight = 650,
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

surface.CreateFont( "loading_font", {
	font = "Default",
	size = 64,
	weight = 650,
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

/*------------------------------------------
				F2 Team Select
------------------------------------------*/

net.Receive("teamselect", function()
	local menu = vgui.Create("DFrame")
	menu:SetTitle("")
	menu:SetSize(ScrW()/2.5, ScrH())
	menu:AlignRight()
	menu:SetDraggable(false)
	menu:ShowCloseButton(false)
	function menu:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 150))
	end
	menu:MakePopup()

	local bBlueTeam = vgui.Create("DButton")
	bBlueTeam:SetParent(menu)
	bBlueTeam:SetText("Join Duel")
	bBlueTeam:SetTextColor(Color(0,0,0))
	bBlueTeam:SetFont("team_font")
	bBlueTeam:SetSize(ScrW()/2.5, 150)
	bBlueTeam:SetPos(0, 350)
	function bBlueTeam:DoClick()
		RunConsoleCommand("pk_team", "1")
		menu:SetVisible(false)
	end
	function bBlueTeam:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, team.GetColor(1))
	end

	local bSpec = vgui.Create("DButton")
	bSpec:SetParent(menu)
	bSpec:SetText("Spectate")
	bSpec:SetTextColor(Color(0,0,0))
	bSpec:SetFont("team_font")
	bSpec:SetSize(ScrW()/2.5, 150)
	bSpec:SetPos(0, 500)
	function bSpec:DoClick()
		RunConsoleCommand("pk_team", "0")
		menu:SetVisible(false)
	end
	function bSpec:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, team.GetColor(0))
	end
end)