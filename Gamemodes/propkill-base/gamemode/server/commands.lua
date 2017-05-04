function ChangeTeam(ply, cmd, args)
	local teamindex = tonumber(args[1])
	if teamindex < 1000 and team.Valid(teamindex) then
		ChatMsg({team.GetColor(ply:Team()), ply:Nick(), cwhite, " has joined team ", team.GetColor(teamindex), team.GetName(teamindex), "!"})
		ply:SetTeam(teamindex)
		ply:Spawn()
	end
end
concommand.Add("pk_team", ChangeTeam)

concommand.Add("rserver", function(ply)
	if ply:IsSuperAdmin() then
		print("Restarting server...")
		RunConsoleCommand("changelevel", game.GetMap(), "propkill")
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
