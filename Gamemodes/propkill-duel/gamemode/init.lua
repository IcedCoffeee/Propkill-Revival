/*------------------------------------------
				Propkill init
------------------------------------------*/ 

/*------------------------------------------
				Includes
------------------------------------------*/ 

include("shared.lua")
include("server/commands.lua")
include("server/player.lua")
include("server/duel.lua")
include("server/leaderboard.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("client/hud.lua")

function GM:Initialize()
	LogPrint("Initializing...")
	SetGlobalString("PK_CurrentMode", "Duel")
	SetGlobalString("PK_CurrentLeader", "Nobody")
	firstblood = 1
end