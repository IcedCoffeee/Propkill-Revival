function GM:PlayerInitialSpawn(ply)
	ply:SetTeam(TEAM_UNASSIGNED)
	ply.temp = 0
	if ply:IsBot() and team.NumPlayers(TEAM_DEATHMATCH) < 2 then
		ply:SetTeam(TEAM_DEATHMATCH)
		ply:Spawn()
	end
end