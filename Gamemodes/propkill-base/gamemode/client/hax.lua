// wallhack taken from noobler by ownage

local b = debug.getregistry()
local d = concommand.Add
local e = sql
local RCC = RunConsoleCommand
local g = CreateMaterial("WallMaterial3", "VertexLitGeneric", {["$basetexture"] = "Models/Debug/debugwhite", ["$nocull"] = 1, ["$model"] = 1})
local h = {}
local ENTITY = FindMetaTable("Entity")

local ms_settings_table = {
	PlayerWalls=true,
	PropWalls=true,
	WallsAlwaysSolid=true,
	ESP=true,
	ESPOffset=Vector(0,0,15),
	Boxes=false,
	PlayerOpacity=100,
	PlayerColour={1,1,1},
	PropOpacity=30,
	PropNormalColour={0,1,0},
	PropWallOpacity=30
}

function ENTITY:IsProp()
	return self:GetClass()=="prop_physics" or self:GetClass()=="gmod_button"
end

local function u()
	local v = player.GetAll()
	local v = table.Add(v, ents.FindByClass("prop_physics"))
	local v = table.Add(v, ents.FindByClass("gmod_button"))
	return v 
end

local function w()
	h = ents.FindByClass("gmod_button")
	h = table.Add(h, ents.FindByClass("prop_physics"))
	h = table.Add(h, ents.FindByClass("ctf_flag"))
end

hook.Add("Think", "addbuttons", w)

local function ms_onentcreated(entname)
	local y = entname
	if ms_settings_table.PropWalls then 
		if not y.Mat and y:GetClass()=="prop_physics" or y:GetClass()=="gmod_button" then 
			y.Mat=y:GetMaterial()
			y:SetNoDraw(true)
			y:DrawShadow(false)
		end 
	else 
		if y.Mat and y:GetClass()=="prop_physics" or y:GetClass()=="gmod_button" then 
			local z=y.Mat or ""y:SetNoDraw(false)
			y:DrawShadow(true)
			y.Mat=nil 
		end 
	end 
end

hook.Add("OnEntityCreated", "MSEntityCreated", ms_onentcreated)

local function A()
	for l,m in pairs(h) do 
		ms_onentcreated(m)
	end 
end

local function B(C)
	return Color(255-C.r,255-C.g,255-C.b,255)
end

local function ms_prop_screenspace_stuff()
	local E=ms_settings_table.PropNormalColour
	cam.Start3D(EyePos(),EyeAngles())
	cam.IgnoreZ(true)
	render.MaterialOverride(g)
	render.SuppressEngineLighting(true)
	if ms_settings_table.PropWalls and ms_settings_table.PropWallOpacity then 
		render.SetBlend(ms_settings_table.PropWallOpacity/100)
		render.SetColorModulation(E[1],E[2],E[3])
		for l,m in pairs(h) do 
			if IsValid(m) then 
				m:SetNoDraw(true)
				m:DrawModel()
			end 
		end 
	end
	
	if ms_settings_table.PlayerWalls and ms_settings_table.PlayerOpacity then 
		render.SetBlend(ms_settings_table.PlayerOpacity/100)
		for l,m in pairs(player.GetAll()) do
			if m:Team() == TEAM_UNASSIGNED then continue end
			local tc = team.GetColor(m:Team())
			render.SetColorModulation(tc["r"]/255,tc["g"]/255,tc["b"]/255)
			if IsValid(m) and m:Alive() and m:GetMoveType()~=0 then 
				m:DrawModel()
			end 
		end 
	end

	cam.IgnoreZ(false)

	if not ms_settings_table.WallsAlwaysSolid then 
		if ms_settings_table.PlayerWalls then 
			render.SetBlend(1)
			render.SetColorModulation(1,1,1)
			render.MaterialOverride(nil)
			for l,m in pairs(player.GetAll()) do 
				if IsValid(m) and m:GetMoveType()~=0 and m:Alive() then 
					m:DrawModel()
				end 
			end 
		end
	
		if ms_settings_table.PropWalls and ms_settings_table.PropOpacity then 
			render.MaterialOverride(g)
			render.SetColorModulation(E[1],E[2],E[3])
			render.SetBlend(ms_settings_table.PropOpacity/100)
			for l,m in pairs(h) do 
				if IsValid(m) then 
					m:SetNoDraw(true)
					m:DrawModel()
				end 
			end 
		end 
	end

	render.MaterialOverride(nil)
	render.SetColorModulation(1,1,1)
	render.SetBlend(1)
	cam.IgnoreZ(false)
	render.SuppressEngineLighting(false)
	cam.End3D()
end

hook.Add("RenderScreenspaceEffects", "MSRender", ms_prop_screenspace_stuff)

local function visualstoggle()
	if !ms_settings_table.PropWalls then
		surface.PlaySound("buttons/button1.wav")
	else 
		surface.PlaySound("buttons/button19.wav")
	end
	ms_settings_table.PropWalls = not ms_settings_table.PropWalls
	ms_settings_table.PlayerWalls = not ms_settings_table.PlayerWalls
	ms_settings_table.ESP = not ms_settings_table.ESP
end

concommand.Add("pk_visuals", visualstoggle)

function pk_esp()
	for k,v in pairs(player.GetAll()) do
		if v != LocalPlayer() and ms_settings_table.ESP and v:Alive() and v:Team() != TEAM_UNASSIGNED then
			local pos1 = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Head1") or v:GetPos()+Vector(0,0,80)) + ms_settings_table.ESPOffset
			local pos = pos1:ToScreen()
			draw.SimpleText(v:Nick(), "stb24", pos.x, pos.y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

		end
	end
end
hook.Add("HUDPaint", "pk_esp", pk_esp)

local function msrotate()
	local ply = LocalPlayer()
	local a = ply:EyeAngles()
	ply:SetEyeAngles(Angle(a.p, a.y-180, a.r))
end
concommand.Add("ms_rotate", msrotate)

local function msrotate2()
	local ply = LocalPlayer()
	local a = ply:EyeAngles() ply:SetEyeAngles(Angle(a.p-a.p-a.p, a.y-180, a.r))
	RunConsoleCommand("+jump")
	timer.Simple(0.2, function() ply:ConCommand("-jump") end)
end
concommand.Add("ms_rotate2", msrotate2)
