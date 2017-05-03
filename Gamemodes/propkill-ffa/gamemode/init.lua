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

util.AddNetworkString("pk_teamselect")
util.AddNetworkString("pk_helpmenu")

function GM:Initialize()
	LogPrint("Initializing...")
	SetGlobalString("PK_CurrentMode", "Free For All")
	SetGlobalString("PK_CurrentLeader", "Nobody")
	firstblood = 1
end