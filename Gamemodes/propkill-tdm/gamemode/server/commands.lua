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

function AutoBalance(ply)
	if !ply:IsSuperAdmin() then return false end
	LogPrint("Balancing and shuffling teams...")
	ChatMsg({"Teams have been shuffled and balanced"})
	local plys = shuffle(player.GetAll())
	newteam = 1
	for k,v in pairs(plys) do
		if newteam == 1 then
			v:SetTeam(newteam)
			newteam = 2
		elseif newteam == 2 then
			v:SetTeam(newteam)
			newteam = 1
		end
		v:Spawn()
	end
end
concommand.Add("pk_autobalance", AutoBalance)
