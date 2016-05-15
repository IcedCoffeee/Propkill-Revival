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

	local bRedTeam = vgui.Create("DButton")
	bRedTeam:SetParent(menu)
	bRedTeam:SetText("Join Red Team")
	bRedTeam:SetTextColor(Color(0,0,0))
	bRedTeam:SetFont("team_font")
	bRedTeam:SetSize(ScrW()/2.5, 150)
	bRedTeam:SetPos(0, 200)
	function bRedTeam:DoClick()
		RunConsoleCommand("pk_team", "1")
		menu:SetVisible(false)
	end
	function bRedTeam:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, team.GetColor(1))
	end

	local bBlueTeam = vgui.Create("DButton")
	bBlueTeam:SetParent(menu)
	bBlueTeam:SetText("Join Blue Team")
	bBlueTeam:SetTextColor(Color(0,0,0))
	bBlueTeam:SetFont("team_font")
	bBlueTeam:SetSize(ScrW()/2.5, 150)
	bBlueTeam:SetPos(0, 350)
	function bBlueTeam:DoClick()
		RunConsoleCommand("pk_team", "2")
		menu:SetVisible(false)
	end
	function bBlueTeam:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, team.GetColor(2))
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
		draw.RoundedBox(0, 0, 0, w, h, team.GetColor(3))
	end
end)

/*------------------------------------------
				F1 Propkill Help
------------------------------------------*/

function PKHelp()
	local helpframe = vgui.Create("DFrame")
	helpframe:SetSize(ScrW() - 200, ScrH() - 150)
	helpframe:Center()
	helpframe:ShowCloseButton(true)
	helpframe:SetDraggable(false)
	helpframe:SetTitle("Propkill Help")
	function helpframe:Paint(w, h)
		draw.SimpleText("Loading...", "loading_font", 870, 480, Color(255,255,255,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 170))
	end
	helpframe:MakePopup()

	local scrollpanel = vgui.Create("DScrollPanel", helpframe)
	scrollpanel:SetSize(ScrW() - 190, ScrH() - 135)
	scrollpanel:SetPos(0, 25)
	function scrollpanel:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(70, 70, 70, 170))
	end

	local html = vgui.Create("HTML", helpframe)
	html:SetPos(0, 0)
	html:Dock(FILL)
	html:OpenURL("http://www.google.com")
end

net.Receive("helpmenu", PKHelp)