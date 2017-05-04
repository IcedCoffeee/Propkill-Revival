GM.Name = "Propkill"
GM.Author = "Iced Coffee & Almighty Laxz"
GM.Email = "N/A"
GM.Website = "N/A"

GM.TeamBased = true

DeriveGamemode("propkill-base")

function GM:CreateTeams()
	TEAM_UNASSIGNED = 0
	TEAM_RED = 1
	TEAM_BLUE = 2
	team.SetUp(TEAM_RED, "Red Team", Color(255, 50, 20, 255))
	team.SetUp(TEAM_BLUE, "Blue Team", Color(50, 70, 255, 255))
	team.SetUp(TEAM_UNASSIGNED, "Spectator", Color(70, 70, 70, 255))

	team.SetSpawnPoint(TEAM_RED, {"info_player_terrorist"})
	team.SetSpawnPoint(TEAM_BLUE, {"info_player_counterterrorist"})
	team.SetSpawnPoint(TEAM_UNASSIGNED, {"worldspawn"})
end
