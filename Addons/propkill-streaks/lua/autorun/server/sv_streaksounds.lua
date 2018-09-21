util.AddNetworkString("killstreakmessage")

hook.Add("PlayerInitialSpawn", "PK_ResetStreakCount", function(ply)
	ply.streak = 0
end)

function handlestreak(ply)
	if IsValid(ply) and ply.streak != nil then
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

hook.Add("PlayerDeath", "PK_HandleStreak", function(ply, inflictor, dmg)
	if (inflictor:GetClass() == "prop_physics") then 
		local propOwner = inflictor.Owner
		attacker = propOwner

		if (propOwner != ply) then
			attacker.streak = attacker.streak + 1
			handlestreak(attacker)
		end
	end
	ply.streak = 0
end)

hook.Add("PlayerSpawn", "PK_ResetStreakCount", function(ply)
	ply.streak = 0
end)