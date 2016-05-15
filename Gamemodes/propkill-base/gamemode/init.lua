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