include("sh_streaksounds.lua")

AddCSLuaFile("sh_streaksounds.lua")

util.AddNetworkString("killstreakmessage")

function handlestreak(ply)
	if IsValid(ply) then
		for k,v in pairs(streaks) do
			if ply.streak == 1 and firstblood == 1 then
				net.Start("killstreakmessage")
				net.WriteTable({text = ply:Nick() .. " " .. v.text, sound = v.sound})
				net.Broadcast()
				firstblood = 0
			elseif ply.streak == k and ply.streak != 1 and ply.streak <= 16 then
				net.Start("killstreakmessage")
				net.WriteTable({text = ply:Nick() .. " " .. v.text, sound = v.sound})
				net.Broadcast()
			end
		end
		if ply.streak >= 17 then
			net.Start("killstreakmessage")
			net.WriteTable({text = ply:Nick() .. " " .. streaks[17].text, sound = streaks[17].sound})
			net.Broadcast()
		end
	end
end

hook.Add("PlayerDeath", "PK_HandleStreak", function(ply, attacker, dmg)
	handlestreak(attacker)
end)

hook.Add("PlayerSpawn", "PK_ResetStreakCount", function(ply)
	ply.streak = 0
end)