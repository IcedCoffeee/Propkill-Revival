function ChangeTeam(ply, cmd, args)
	if args[1] == "0" then
		ChatMsg({team.GetColor(ply:Team()), ply:Nick(), Color(255,255,255), " has joined team ", team.GetColor(3), "Spectator!"})
		ply:SetTeam(TEAM_UNASSIGNED)
		ply:Spawn()
	end
	
	if args[1] == "1" then
		ChatMsg({team.GetColor(ply:Team()), ply:Nick(), Color(255,255,255), " has joined team ", team.GetColor(1), "Red!"})
		ply:SetTeam(TEAM_RED)
		ply:Spawn()
	end

	if args[1] == "2" then
		ChatMsg({team.GetColor(ply:Team()), ply:Nick(), Color(255,255,255), " has joined team ", team.GetColor(2), "Blue!"})
		ply:SetTeam(TEAM_BLUE)
		ply:Spawn()
	end
end
concommand.Add("pk_team", ChangeTeam)
