function ChangeTeam(ply, cmd, args)
	local teamindex = tonumber(args[1])

	for k,v in pairs(team.GetAllTeams()) do
		if tostring(teamindex) == tostring(k) && k < 1000 then
			ChatMsg({team.GetColor(ply:Team()), ply:Nick(), cwhite, " has joined team ", team.GetColor(teamindex), team.GetName(teamindex), "!"})
			ply:SetTeam(teamindex)
			ply:Spawn()
		end
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