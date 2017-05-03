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
	html:OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=572479773")
end

net.Receive("pk_helpmenu", PKHelp)

/*------------------------------------------
				F2 Team Select
------------------------------------------*/

local function RealTeams()
	local count = 0
	
	for k,v in pairs(team.GetAllTeams()) do
		if k < 1000 then
			count = count + 1
		end
	end
	return count
end

net.Receive("pk_teamselect", function()
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

	local panel = vgui.Create("DPanel", menu)
	panel:SetSize(ScrW()/2.5, 150 * RealTeams())
	panel:Center()

	print("REALTEAMS: " .. RealTeams())
	print("PANEL SIZE: " .. 150 * RealTeams())

	local tbl = {}

	for k,v in pairs(team.GetAllTeams()) do
		if k > 999 then return false end
		local btn = tbl[k]
		btn = vgui.Create("DButton", panel)
		btn:SetText(team.GetName(k))
		btn:Dock(TOP)
		btn:SetTextColor(Color(0,0,0))
		btn:SetFont("team_font")
		btn:SetSize(ScrW()/2.5, 150)

		if k == 0 then
			btn:SetText("Spectate")
			btn:Dock(BOTTOM)
		end

		function btn:DoClick()
			RunConsoleCommand("pk_team", tostring(k))
			menu:SetVisible(false)
		end
		function btn:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, team.GetColor(k))
		end
	end
	panel:Center()
end)