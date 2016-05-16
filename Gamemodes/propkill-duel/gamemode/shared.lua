GM.Name = "Propkill: Duel"
GM.Author = "Iced Coffee & Almighty Laxz"
GM.Email = "N/A"
GM.Website = "N/A"

GM.TeamBased = true

DeriveGamemode("propkill-base")

function GM:CreateTeams()
	TEAM_UNASSIGNED = 0
	TEAM_DEATHMATCH = 1
	team.SetUp(TEAM_DEATHMATCH, "Deathmatch", Color(255, 50, 20, 255))
	team.SetUp(TEAM_UNASSIGNED, "Unassigned", Color(70, 70, 70, 255))

	//team.SetSpawnPoint(TEAM_RED, {"info_player_terrorist"})
	team.SetSpawnPoint(TEAM_UNASSIGNED, {"worldspawn"})
end