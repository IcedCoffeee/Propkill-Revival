function ChangeTeam(ply, cmd, args)
	if GetGlobalBool("PK_Dueling") then
		ply:ChatPrint("no")
		return
	end
	local teamindex = tonumber(args[1])
	if teamindex < 1000 and team.Valid(teamindex) then
		GAMEMODE:PlayerJoinTeam(ply, teamindex)
	end
end
concommand.Add("pk_team", ChangeTeam)

concommand.Add("rserver", function(ply)
	if ply:IsSuperAdmin() then
		print("Restarting server...")
		RunConsoleCommand("changelevel", game.GetMap(), engine.ActiveGamemode())
	end
end)

function StartGame()
	// Should be overridden
end

function WarmUp()
	SetGlobalBool("Warmup", true)
	timer.Simple(60, function()
		SetGlobalBool("Warmup", false)
		StartGame()
	end)
end

function PK_PhysSettings()
	if ply:IsSuperAdmin() then
		if args[1] then
			physenv.SetPerformanceSettings(
				{
					LookAheadTimeObjectsVsObject = 2,
					LookAheadTimeObjectsVsWorld = 21,
					MaxAngularVelocity = 3636,
					MaxCollisionChecksPerTimestep = 5000,
					MaxCollisionsPerObjectPerTimestep = 48,
					MaxFrictionMass = 1,
					MaxVelocity = 2200,
					MinFrictionMass = 99999,
				}
			)
			game.ConsoleCommand("physgun_DampingFactor 1\n")
			game.ConsoleCommand("physgun_timeToArrive 0.01\n")
			game.ConsoleCommand("sv_sticktoground 0\n")
			game.ConsoleCommand("sv_airaccelerate 2000\n")
			ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Australian physics settings enabled"})
		else
			-- ??
			ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Australian physics settings disabled"})
		end
	end
end
concommand.Add("pk_physsettings", PK_PhysSettings)
