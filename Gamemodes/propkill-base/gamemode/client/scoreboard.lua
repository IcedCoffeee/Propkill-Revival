surface.CreateFont("pk_scoreboardfont", {
	font = "stb24",
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
	shadow = true,
	additive = false,
	outline = false,
})

surface.CreateFont("pk_teamfont", {
	font = "stb24",
	size = 18,
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
})

function GM:ScoreboardShow()
	scoreboardframe = vgui.Create("DFrame")
	scoreboardframe:SetTitle("")
	//frame:SetSize(800, 800)
	scoreboardframe:SetDraggable(false)
	scoreboardframe:ShowCloseButton(false)
	function scoreboardframe:Paint(w, h)
	
	end
	//frame:MakePopup()
	
	local base = vgui.Create("DPanel", scoreboardframe)
	//base:Dock(FILL)
	base:SetWidth(800)
	function base:Paint(w,h)
		//draw.RoundedBox(0, 0, 0, w, h, Color(236,240,241))
	end
	
	local header = vgui.Create("DPanel", base)
	header:Dock(TOP)
	header:DockMargin(0,0,0,0)
	header:SetHeight(80)
	function header:Paint(w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(33,150,243))
	end
	
	local svrname = vgui.Create("DLabel", header)
	svrname:Dock(TOP)
	svrname:SetHeight(50)
	svrname:SetText("")
	function svrname:Paint(w,h)
		draw.SimpleText(GetHostName(), "pk_scoreboardfont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	local gmname = vgui.Create("DLabel", header)
	gmname:Dock(TOP)
	gmname:SetHeight(20)
	gmname:SetText("")
	function gmname:Paint(w,h)
		draw.SimpleText(GetGlobalString("PK_CurrentMode", ""), "stb24", w/2, h/2-3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	local columns = vgui.Create("DPanel", base)
	columns:SetSize(0,30)
	columns:Dock(TOP)
	columns:DockMargin(0,0,0,10)
	function columns:Paint(w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(97,97,97))
	end
	
	local name = vgui.Create("DLabel", columns)
	name:SetText("")
	name:Dock(LEFT)
	name:SetWidth(300)
	function name:Paint(w,h)
		draw.SimpleText("Name", "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	local ping = vgui.Create("DLabel", columns)
	ping:SetText("")
	ping:Dock(RIGHT)
	ping:SetWidth(120)
	function ping:Paint(w,h)
		draw.SimpleText("Ping", "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	local deaths = vgui.Create("DLabel", columns)
	deaths:SetText("")
	deaths:Dock(RIGHT)
	deaths:SetWidth(120)
	function deaths:Paint(w,h)
		draw.SimpleText("Deaths", "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	local kills = vgui.Create("DLabel", columns)
	kills:SetText("")
	kills:Dock(RIGHT)
	kills:SetWidth(120)
	function kills:Paint(w,h)
		draw.SimpleText("Kills", "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	for k,v in pairs(team.GetAllTeams()) do
		if k < 1000 and #team.GetPlayers(k) > 0 then
			local cat = vgui.Create("DPanel", base)
			cat:SetSize(0,30)
			cat:Dock(TOP)
			cat:DockMargin(0,0,0,0)
			function cat:Paint(w,h)
				draw.RoundedBox(0, 0, 0, w, h, team.GetColor(k))
			end
			local teamname = vgui.Create("DLabel", cat)
			teamname:SetText("")
			teamname:Dock(FILL)
			function teamname:Paint(w,h)
				draw.SimpleText(team.GetName(k) .. " (" .. team.GetScore(k) .. ")", "pk_teamfont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			local playerframe = vgui.Create("DPanel", base)
			playerframe:Dock(TOP)
			playerframe:DockMargin(0,0,0,10)
			function playerframe:Paint(w,h)
				local tc = team.GetColor(k)
				local fade = Color(tc["r"],tc["g"],tc["b"],tc["a"]/2)
				//draw.RoundedBox(0, 0, 0, w, h, fade)
			end
			
			for l,m in pairs(team.GetPlayers(k)) do
				local playerrow = vgui.Create("DPanel", playerframe)
				playerrow:Dock(TOP)
				playerrow:DockMargin(0,0,0,5)
				playerrow:SetHeight(25)
				function playerrow:Paint(w,h)
					local tc = team.GetColor(k)
					local fade = Color(tc["r"],tc["g"],tc["b"],tc["a"]/1.5)
					draw.RoundedBox(0, 0, 0, w, h, Color(80,80,80,225))
				end
				
				local playername = vgui.Create("DLabel", playerrow)
				playername:SetText("")
				playername:SetWidth(250)
				playername:Dock(LEFT)
				function playername:Paint(w,h)
					draw.SimpleText(m:Nick(), "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
				
				local playerping = vgui.Create("DLabel", playerrow)
				playerping:SetText("")
				playerping:Dock(RIGHT)
				playerping:SetWidth(120)
				function playerping:Paint(w,h)
					draw.SimpleText(m:Ping(), "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
				
				local playerdeaths = vgui.Create("DLabel", playerrow)
				playerdeaths:SetText("")
				playerdeaths:Dock(RIGHT)
				playerdeaths:SetWidth(120)
				function playerdeaths:Paint(w,h)
					draw.SimpleText(m:Deaths(), "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
				
				local playerkills = vgui.Create("DLabel", playerrow)
				playerkills:SetText("")
				playerkills:Dock(RIGHT)
				playerkills:SetWidth(120)
				function playerkills:Paint(w,h)
					draw.SimpleText(m:Frags(), "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
				
				//local playerscore = vgui.Create("DLabel", playerrow)
				//playerscore:SetText("")
				//playerscore:Dock(RIGHT)
				//playerscore:SetWidth(120)
				//function playerscore:Paint(w,h)
				//	draw.SimpleText(0, "pk_teamfont", 20, h/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				//end
				
			end
			playerframe:InvalidateLayout(true)
			playerframe:SizeToChildren(false, true)
			//local plylist = vgui.Create("DPanel", cat)
			//plylist:Dock(FILL)
			//function plylist:Paint(w,h)
			//	draw.RoundedBox(0, 0, 0, w, h, Color(0,255,0))
			//end
		end
	end
	base:InvalidateLayout(true)
	base:SizeToChildren(false,true)
	scoreboardframe:InvalidateLayout(true)
	scoreboardframe:SizeToChildren(true, true)
	scoreboardframe:Center()
end

function GM:ScoreboardHide()
	scoreboardframe:Close()
end
