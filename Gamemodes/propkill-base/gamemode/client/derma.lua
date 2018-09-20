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
	pk_cancloseteamselect = false
	hook.Add("Think", "pk_checkf2key", function()
		if !input.IsKeyDown(KEY_F2) then
			pk_cancloseteamselect = true
		end
   		if input.IsKeyDown(KEY_F2) and pk_cancloseteamselect then
   			if IsValid(pk_teamselectmenu) then
   				pk_teamselectmenu:Remove()
   			end
   			hook.Remove("Think", "pk_checkf2key")
   		end
	end)
	pk_teamselectmenu = vgui.Create("DFrame")
	pk_teamselectmenu:SetTitle("")
	pk_teamselectmenu:SetSize(ScrW()/2.5, ScrH())
	pk_teamselectmenu:AlignRight()
	pk_teamselectmenu:SetDraggable(false)
	pk_teamselectmenu:ShowCloseButton(false)
	function pk_teamselectmenu:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 150))
	end
	pk_teamselectmenu:MakePopup()

	local panel = vgui.Create("DPanel", pk_teamselectmenu)
	panel:SetSize(ScrW()/2.5, 150 * RealTeams())
	panel:Center()

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
			pk_teamselectmenu:Remove()
		end
		function btn:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, team.GetColor(k))
		end
	end
	panel:Center()
end)

/*------------------------------------------
				F4 PK Settings
------------------------------------------*/

function PKSettings()
	local helpframe = vgui.Create("DFrame")
	helpframe:SetSize(ScrW() - 500, ScrH() - 400)
	helpframe:Center()
	helpframe:ShowCloseButton(true)
	helpframe:SetDraggable(false)
	helpframe:SetTitle("Propkill Settings")
	function helpframe:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 170))
	end
	helpframe:MakePopup()

	local scrollpanel = vgui.Create("DScrollPanel", helpframe)
	scrollpanel:SetSize(ScrW() - 190, ScrH() - 135)
	scrollpanel:SetPos(0, 25)
	function scrollpanel:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(70, 70, 70, 170))
	end

	local physics_checkbox = vgui.Create("DCheckBoxLabel")
	physics_checkbox:SetParent(scrollpanel)
	physics_checkbox:SetPos(25, 50)			
	physics_checkbox:SetText("Use lerp command (more responsive props)")		
	physics_checkbox:SetConVar("pk_cl_physics")
	physics_checkbox:SetValue(1)
	physics_checkbox:SizeToContents()

	local visuals_checkbox = vgui.Create("DCheckBoxLabel")
	visuals_checkbox:SetParent(scrollpanel)
	visuals_checkbox:SetPos(25, 75)
	visuals_checkbox:SetText("Enable built-in wallhack and ESP")		
	visuals_checkbox:SetConVar("pk_visuals")
	visuals_checkbox:SetValue(1)
	visuals_checkbox:SizeToContents()

	local visuals_checkbox = vgui.Create("DCheckBoxLabel")
	visuals_checkbox:SetParent(scrollpanel)
	visuals_checkbox:SetPos(25, 100)	
	visuals_checkbox:Toggle()
	visuals_checkbox:SetText("Enable rooftiles in skybox")		
	visuals_checkbox:SetConVar("pk_rooftiles")
	visuals_checkbox:SetValue(false)
	visuals_checkbox:SizeToContents()

	local removeskybox_checkbox = vgui.Create("DCheckBoxLabel")
	removeskybox_checkbox:SetParent(scrollpanel)
	removeskybox_checkbox:SetPos(25, 125)
	removeskybox_checkbox:Toggle()
	removeskybox_checkbox:SetText("Replace skybox with grey")		
	removeskybox_checkbox:SetConVar("pk_removeskybox")
	removeskybox_checkbox:SetValue(false)
	removeskybox_checkbox:SizeToContents()

	local vertbeam_checkbox = vgui.Create("DCheckBoxLabel")
	vertbeam_checkbox:SetParent(scrollpanel)
	vertbeam_checkbox:SetPos(25, 150)
	vertbeam_checkbox:Toggle()
	vertbeam_checkbox:SetText("Vertical beam on players")		
	vertbeam_checkbox:SetConVar("pk_vertbeam")
	vertbeam_checkbox:SetValue(false)
	vertbeam_checkbox:SizeToContents()
end

net.Receive("pk_settingsmenu", PKSettings)