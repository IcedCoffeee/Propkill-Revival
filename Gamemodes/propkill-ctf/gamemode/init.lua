/*------------------------------------------
				Propkill init
------------------------------------------*/ 

/*------------------------------------------
				Includes
------------------------------------------*/ 

include("shared.lua")
include("server/flag.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("client/hud.lua")

/*------------------------------------------
				Network Strings
------------------------------------------*/ 


function GM:Initialize()
	LogPrint("Initializing...")
	SetGlobalString("PK_CurrentMode", "Capture The Flag")
	SetGlobalString("PK_CurrentLeader", "Nobody")
	firstblood = 1
end
