/*
function EndGame()
	SetGlobalBool("TDM_Playing", false)
	ChatMsg({Color(255,255,255), "Final Score: ", Color(255,0,0), tostring(team.GetScore(1)), Color(255,255,255), "-", Color(0,0,255), tostring(team.GetScore(2))})
end
concommand.Add("pk_endgame", EndGame)

function StartGame()
	// how long the game will last in seconds
	local gamelength = 600
	team.SetScore(1, 0)
	team.SetScore(2, 0)
	SetGlobalBool("TDM_Playing", true)
	SetGlobalInt("TDM_Time_Left", gamelength)
	ChatMsg({Color(255,255,255), "Starting game."})
	for k,v in pairs(player.GetAll()) do
		v:Spawn()
		v:Freeze(true)
	end
	timer.Simple(3, function()
		for k,v in pairs(player.GetAll()) do
			v:Freeze(false)
		end

		timer.Create("TDM_Game_Timer", 1, gamelength, function()
			SetGlobalInt("TDM_Time_Left", timer.RepsLeft("TDM_Game_Timer"))
		end)
		timer.Simple(gamelength, EndGame)
	end)
end
concommand.Add("pk_startgame", StartGame)
*/