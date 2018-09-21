function GM:PlayerInitialSpawn(ply)
	ply:SetTeam(TEAM_UNASSIGNED)
	ply.temp = 0
	if ply:IsBot() then
		ply:SetTeam(TEAM_UNASSIGNED)
	end
	ply:Spawn()
end

