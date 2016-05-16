/*------------------------------------------
				Propkill init
------------------------------------------*/ 

/*------------------------------------------
				Includes
------------------------------------------*/ 

include("shared.lua")
include("server/player.lua")
include("server/commands.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("client/derma.lua")

/*------------------------------------------
				Network Strings
------------------------------------------*/ 

util.AddNetworkString("teamselect")
util.AddNetworkString("helpmenu")

function GM:Initialize()
	LogPrint("Initializing TDM-E...")
	SetGlobalString("PK_CurrentMode", "Team Elimination")
	SetGlobalString("PK_CurrentLeader", "Nobody")
	firstblood = 1
end