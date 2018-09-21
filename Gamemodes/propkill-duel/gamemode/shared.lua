GM.Name = "Propkill"
GM.Author = "Iced Coffee & Almighty Laxz"
GM.Email = "N/A"
GM.Website = "N/A"

GM.TeamBased = false

DeriveGamemode("propkill-base")

function GM:CreateTeams()
	TEAM_DEATHMATCH = 1
	TEAM_UNASSIGNED = 0
	team.SetUp(TEAM_DEATHMATCH, "Dueler", Color(255, 50, 20, 255))
	team.SetUp(TEAM_UNASSIGNED, "Spectator", Color(70, 70, 70, 255))

	//team.SetSpawnPoint(TEAM_RED, {"info_player_terrorist"})
	team.SetSpawnPoint(TEAM_UNASSIGNED, {"worldspawn"})
end