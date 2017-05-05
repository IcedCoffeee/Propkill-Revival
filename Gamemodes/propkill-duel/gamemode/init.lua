/*------------------------------------------
				Propkill init
------------------------------------------*/ 

/*------------------------------------------
				Includes
------------------------------------------*/ 

include("shared.lua")
include("server/commands.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function GM:Initialize()
	LogPrint("Initializing...")
	SetGlobalString("PK_CurrentMode", "Duel")
	SetGlobalString("PK_CurrentLeader", "Nobody")
	firstblood = 1
end