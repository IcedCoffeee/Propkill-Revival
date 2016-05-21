/*------------------------------------------
				Propkill init
------------------------------------------*/ 

/*------------------------------------------
				Includes
------------------------------------------*/ 

include("shared.lua")
include("server/player.lua")
include("server/entity.lua")
include("server/commands.lua")
include("server/base.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("client/hud.lua")
AddCSLuaFile("client/hax.lua")
AddCSLuaFile("client/scrubkeys.lua")
AddCSLuaFile("client/scoreboard.lua")

/*------------------------------------------
				Network Strings
------------------------------------------*/ 

util.AddNetworkString("KilledByProp")
util.AddNetworkString("chatmsg")
util.AddNetworkString("killstreakmessage")

function GM:Initialize()
	LogPrint("Initializing...")
	SetGlobalString("PK_CurrentMode", "Deathmatch")
	SetGlobalString("PK_CurrentLeader", "Nobody")
	firstblood = 1
end

timer.Create("PK_Clear_Decals", 30, 0, function()
	for k,v in pairs(player.GetAll()) do
		v:ConCommand("r_cleardecals")
	end
end)