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
include("server/rounds.lua")
include("shared/entity.lua")
include("server/leaderboard.lua")
include("server/duel.lua")
include("server/config.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("client/hud.lua")
AddCSLuaFile("client/hax.lua")
AddCSLuaFile("client/scrubkeys.lua")
AddCSLuaFile("client/scoreboard.lua")
AddCSLuaFile("client/derma.lua")
AddCSLuaFile("client/base.lua")
AddCSLuaFile("client/commands.lua")
AddCSLuaFile("shared/entity.lua")

/*------------------------------------------
				Network Strings
------------------------------------------*/ 

util.AddNetworkString("KilledByProp")
util.AddNetworkString("pk_chatmsg")
util.AddNetworkString("pk_notify")
util.AddNetworkString("pk_teamselect")
util.AddNetworkString("pk_helpmenu")
util.AddNetworkString("pk_settingsmenu")
util.AddNetworkString("pk_gamenotify")
util.AddNetworkString("pk_leaderboard")
util.AddNetworkString("pk_duelinvite")
util.AddNetworkString("pk_acceptduel")
util.AddNetworkString("pk_declineduel")
util.AddNetworkString("pk_matchhistory")

function GM:Initialize()
	LogPrint("Initializing...")
	SetGlobalString("PK_CurrentMode", "Deathmatch")
	SetGlobalString("PK_CurrentLeader", "Nobody")
	SetGlobalString("PK_RoundStatus", "Warmup")
	firstblood = 1
end

timer.Create("PK_Clear_Decals", 30, 0, function()
	for k,v in pairs(player.GetAll()) do
		v:ConCommand("r_cleardecals")
	end
end)


-- Show notification when lua is updated live
if pk_gminitialized and !timer.Exists("PK_UpdateAntiSpam") then
	ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Gamemode was updated!"})
	timer.Create("PK_UpdateAntiSpam", 4, 1, function() end) -- stop spam as each server file is live updated
end
pk_gminitialized = true