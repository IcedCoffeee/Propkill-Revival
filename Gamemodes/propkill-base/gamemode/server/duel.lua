pk_pendingduels = {}

net.Receive("pk_duelinvite", function(len, ply)
	local t = "pk_duelinvite_cooldown_" .. ply:SteamID()
	if timer.Exists(t) then
		ply:ChatPrint("You cannot request a duel for " .. timer.TimeLeft(t) .. " seconds!")
		return
	end
	timer.Create(t, 60, 1, function() return end)

	if GAMEMODE.TeamBased then
		ply:ChatPrint("Duels are not available team-based modes")
		return
	end

	local opponent = net.ReadEntity()
	pk_pendingduels[#pk_pendingduels] = {
		[1] = ply,
		[2] = opponent
	}

	ply:ChatPrint("Duel invite sent!")

	net.Start("pk_duelinvite")
		net.WriteEntity(ply)
	net.Send(opponent)
end)

net.Receive("pk_acceptduel", function(len, ply)
	local valid = false
	local plys = {}
	local toremove = nil
	for k,v in pairs(pk_pendingduels) do
		if v[2] == ply && ply != v[1] then
			valid = true
			plys = v
			local toremove = k
		end
	end

	if GetGlobalBool("PK_Dueling") then
		valid = false
	end

	if !valid then
		print("Invalid duel accept from " .. ply:Nick())
	end
	table.remove(pk_pendingduels, toremove)

	PK_StartDuel(plys[1], plys[2])
end)

net.Receive("pk_declineduel", function(len, ply)
	for k,v in pairs(pk_pendingduels) do
		if v[2] == ply then
			inviter = v[1]
			table.remove(pk_pendingduels, k)
			inviter:ChatPrint(ply:Nick() .. " declined your duel invite!")
		end
	end
	table.remove(pk_pendingduels, toremove)
end)

pk_duel_spawns = {
	["pk_propkillcity_v1n"] = {
		[1] = {"Yellow Warehouse", "pos"},
		[2] = {"Tunnel", "pos"}
	}
}

function PK_StartDuel(ply1, ply2)
	for k,v in pairs(player.GetAll()) do
		if v != ply1 and v != ply2 then
			GAMEMODE:PlayerJoinTeam(v, TEAM_UNASSIGNED)
		else
			GAMEMODE:PlayerJoinTeam(v, TEAM_DEATHMATCH)
		end
	end
	ply1:Kill()
	ply2:Kill()
	SetGlobalBool("PK_Dueling", true)
	SetGlobalInt("PK_ply1_score", 0)
	SetGlobalInt("PK_ply2_score", 0)
	SetGlobalEntity("PK_ply1", ply1)
	SetGlobalEntity("PK_ply2", ply2)
	ply1:SetDeaths(0)
	ply2:SetDeaths(0)
	ply1:SetFrags(0)
	ply2:SetFrags(0)
	ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), ply1:Nick(), " has started a duel with ", ply2:Nick(), "!"})
end

function PK_FinishDuel()
	SetGlobalBool("PK_Dueling", false)
	winner = nil
	loser = nil
	winner_kills = nil
	winner_deaths = nil
	loser_kills = nil
	loser_deaths = nil

	if GetGlobalInt("PK_ply1_score") > GetGlobalInt("PK_ply2_score") then
		winner = GetGlobalEntity("PK_ply1")
		loser = GetGlobalEntity("PK_ply2")
	else
		winner = GetGlobalEntity("PK_ply2")
		loser = GetGlobalEntity("PK_ply1")
	end
	matchResult = {
		["winner"] = {["steamid"] = winner:SteamID(), ["score"] = loser:Deaths()},
		["loser"] = { ["steamid"] = loser:SteamID(), ["score"] = winner:Deaths()}
	}
	uploadMatchResult(matchResult)
	ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), winner:Nick(), " has won the duel! Final score: ", tostring(GetGlobalInt("PK_ply1_score")), "-", tostring(GetGlobalInt("PK_ply2_score"))})
end

hook.Add("PlayerDeath", "PK_Duel_PlayerDeath", function(victim, inflictor, attacker)
	if GetGlobalBool("PK_Dueling") then
		if victim == GetGlobalEntity("PK_ply1") then
			SetGlobalInt("PK_ply2_score", GetGlobalInt("PK_ply2_score") + 1)
			if GetGlobalInt("PK_ply2_score") >= 15 then
				PK_FinishDuel()
			end
		elseif victim == GetGlobalEntity("PK_ply2") then
			SetGlobalInt("PK_ply1_score", GetGlobalInt("PK_ply1_score") + 1)
			if GetGlobalInt("PK_ply1_score") >= 15 then
				PK_FinishDuel()
			end
		end
	end
end)

function PK_CancelDuel()
	ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Duel cancelled!"})
	SetGlobalBool("PK_Dueling", false)
end

hook.Add("PlayerDisconnected", "PK_HandleDC", function(ply)
	if GetGlobalBool("PK_Dueling") then
		if ply == GetGlobalEntity("PK_ply1") or ply == GetGlobalEntity("PK_ply2") then
			PK_CancelDuel()
		end
	end
end)