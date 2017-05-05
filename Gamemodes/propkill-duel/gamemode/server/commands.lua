function ChangeTeam(ply, cmd, args) -- overriding base because we need 2 player limit
	local teamindex = tonumber(args[1])

	if teamindex == TEAM_DEATHMATCH and team.NumPlayers() > 1 then
		Notify(ply, "There are already 2 duelers!")
		return false
	end

	if teamindex < 1000 and team.Valid(teamindex) then
		ChatMsg({team.GetColor(ply:Team()), ply:Nick(), cwhite, " has joined team ", team.GetColor(teamindex), team.GetName(teamindex), "!"})
		ply:SetTeam(teamindex)
		ply:Spawn()
	end
end
concommand.Add("pk_team", ChangeTeam)