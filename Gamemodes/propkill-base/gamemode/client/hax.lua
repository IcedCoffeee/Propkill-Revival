
local b = debug.getregistry()
local d = concommand.Add;
local e = sql;
local RCC = RunConsoleCommand;
local g = CreateMaterial("WallMaterial3", "VertexLitGeneric", {["$basetexture"] = "Models/Debug/debugwhite", ["$nocull"] = 1, ["$model"] = 1})
local h = {}
local ENTITY = FindMetaTable("Entity")

local ms_settings_table = {
	PlayerWalls=true,
	PropWalls=true,
	WallsAlwaysSolid=true,
	ESP=false,
	Boxes=false,
	PlayerOpacity=100,
	PlayerColour={1,1,1},
	PropOpacity=30,
	PropNormalColour={0,1,0},
	PropWallOpacity=30
}

function ENTITY:IsProp()
	return self:GetClass()=="prop_physics" or self:GetClass()=="gmod_button"
end;

local function u()
	local v = player.GetAll()
	local v = table.Add(v, ents.FindByClass("prop_physics"))
	local v = table.Add(v, ents.FindByClass("gmod_button"))
	return v 
end;

local function w()
	h = ents.FindByClass("gmod_button")
	h = table.Add(h, ents.FindByClass("prop_physics"))
end;

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
end;

hook.Add("OnEntityCreated", "MSEntityCreated", ms_onentcreated)

local function A()
	for l,m in pairs(h) do 
		ms_onentcreated(m)
	end 
end;

local function B(C)
	return Color(255-C.r,255-C.g,255-C.b,255)
end;

local function ms_prop_screenspace_stuff()
	local E=ms_settings_table.PropNormalColour;
	local F=ms_settings_table.PlayerColour;
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
	end;
	
	if ms_settings_table.PlayerWalls and ms_settings_table.PlayerOpacity then 
		render.SetBlend(ms_settings_table.PlayerOpacity/100)
		render.SetColorModulation(F[1],F[2],F[3])
		for l,m in pairs(player.GetAll()) do 
			if IsValid(m) and m:Alive() and m:GetMoveType()~=0 then 
				m:DrawModel()
			end 
		end 
	end;

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
		end;
	
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
	end;

	render.MaterialOverride(nil)
	render.SetColorModulation(1,1,1)
	render.SetBlend(1)
	cam.IgnoreZ(false)
	render.SuppressEngineLighting(false)
	cam.End3D()
end;

hook.Add("RenderScreenspaceEffects", "MSRender", ms_prop_screenspace_stuff)

local function visualstoggle()
	if !ms_settings_table.PropWalls then
		surface.PlaySound("buttons/button1.wav")
	else 
		surface.PlaySound("buttons/button19.wav")
	end
	ms_settings_table.PropWalls = not ms_settings_table.PropWalls
	ms_settings_table.PlayerWalls = not ms_settings_table.PlayerWalls
end

concommand.Add("pk_visuals", visualstoggle)

hook.Add("HUDPaint", "pk_esp", function()
	for k,v in pairs(player.GetAll()) do
		if v == LocalPlayer() or !pkESPOn then continue end
		surface.SetFont("stb24")
		surface.SetTextColor(255, 255, 255, 255)
		local pos = v:GetPos():ToScreen()
		surface.SetTextPos(pos.x, pos.y)
		surface.DrawText(v:Nick())
	end
end)

pkESPOn = false

local function esptoggle()
	pkESPOn = not pkESPOn
end

concommand.Add("pk_esp", esptoggle)
