/*------------------------------------------
				Propkill init
------------------------------------------*/ 

/*------------------------------------------
				Includes
------------------------------------------*/ 

include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

/*------------------------------------------
				Network Strings
------------------------------------------*/ 


function GM:Initialize()
	LogPrint("Initializing...")
	SetGlobalString("PK_CurrentMode", "Capture The Flag")
	SetGlobalString("PK_CurrentLeader", "Nobody")
	firstblood = 1
end