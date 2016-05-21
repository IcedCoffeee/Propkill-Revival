include("shared.lua")
include("client/hud.lua")
include("client/hax.lua")
include("client/scrubkeys.lua")
include("client/scoreboard.lua")

net.Receive("chatmsg", function(len) 
	chat.AddText(unpack(net.ReadTable()))
end)

function KilledByProp()
	local ply	   = net.ReadEntity()
	local inflictor = net.ReadString()
	local attacker  = net.ReadEntity()

	GAMEMODE:AddDeathNotice(attacker:Name(), attacker:Team(), inflictor, ply:Name(), ply:Team())
end

net.Receive("KilledByProp", KilledByProp)

hook.Add("PreDrawSkyBox", "removeSkybox", function()
	render.Clear(50, 50, 50, 255)
	return true
end)
RunConsoleCommand("pk_leaderboard")

// Propkill optimized defaults
RunConsoleCommand("cl_drawspawneffect", "0")
RunConsoleCommand("cl_updaterate", "1000")
RunConsoleCommand("cl_interp", "0")
RunConsoleCommand("rate", "1048576")