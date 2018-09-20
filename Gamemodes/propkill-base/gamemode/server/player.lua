function GM:PlayerInitialSpawn(ply)
	ply:SetTeam(TEAM_UNASSIGNED)
	ply.temp = 0
	ply:ConCommand("gm_showteam")
	if ply:IsBot() then
		ply:SetTeam(math.random(1,2))
	end
	ply:Spawn()
end

function GetLeader()
	local kills = 0
	for k,v in pairs(player.GetAll()) do 
		if v.temp >= kills then
			kills = v.temp 
			if kills != 0 then
				local msg = v:Nick() .. " (" .. tostring(kills) .. ")"
				SetGlobalString("PK_CurrentLeader", msg)
			else
				local msg = "Nobody"
				SetGlobalString("PK_CurrentLeader", msg)
			end
		end
	end
end

hook.Add("PlayerSpawn", "PK_PlayerSpawn", function(ply)
	if ply:Team() == TEAM_UNASSIGNED then
		ply:StripWeapons()
		ply:Spectate(OBS_MODE_ROAMING)
		return
	else
		ply:UnSpectate()
	end

	ply.temp = 0

	/*local col = ply:GetInfo("cl_playercolor")
	ply:SetPlayerColor(Vector(col))

	local col = ply:GetInfo("cl_weaponcolor")
	ply:SetWeaponColor(Vector(col))*/
	ply:SetWalkSpeed(400)
	ply:SetRunSpeed(400)
	ply:SetJumpPower(200)
end)

hook.Add("PlayerLoadout", "PK_PlayerSpawn", function(ply)
	ply:SetHealth(1)
	ply:Give("weapon_physgun")
end)

function GM:OnPlayerChangedTeam(ply, old, new)
	ChatMsg({team.GetColor(old), ply:Nick(), cwhite, " has joined team ", team.GetColor(new), team.GetName(new), "!"})
	ply.NextSpawnTime = CurTime()
end

function GM:PlayerDeath(ply, inflictor, attacker)
	if (inflictor:GetClass() == "prop_physics") then 
		local propOwner = inflictor.Owner
		attacker = propOwner

		if (propOwner != ply) then
			attacker:AddFrags(1)
			MsgAll(attacker:Nick() .. " killed " .. ply:Nick() .. "!")
			attacker.temp = attacker.temp + 1
			attacker:SendLua("surface.PlaySound(\"/buttons/lightswitch2.wav\")")
			handlestreak(attacker)
		elseif (propOwner == ply) then
			MsgAll(attacker:Nick() .. " propkilled himself!")
		end
	end

	ply.temp = 0
	ply.NextSpawnTime = CurTime() + 2

	net.Start("KilledByProp")
		net.WriteEntity(ply)
		net.WriteString(inflictor:GetClass())
		net.WriteEntity(attacker)
	net.Broadcast()
	
	GetLeader()
end

function handlestreak(ply)
	if IsValid(ply) then
		for k,v in pairs(streaks) do
			if ply.temp == 1 and firstblood == 1 then
				net.Start("killstreakmessage")
				net.WriteTable({text = ply:Nick() .. " " .. v.text, sound = v.sound})
				net.Broadcast()
				firstblood = 0
			elseif ply.temp == k and ply.temp != 1 and ply.temp <= 16 then
				net.Start("killstreakmessage")
				net.WriteTable({text = ply:Nick() .. " " .. v.text, sound = v.sound})
				net.Broadcast()
			end
		end
		if ply.temp >= 17 then
			net.Start("killstreakmessage")
			net.WriteTable({text = ply:Nick() .. " " .. streaks[17].text, sound = streaks[17].sound})
			net.Broadcast()
		end
	end
end

function GM:PlayerConnect(name, ip)
	ChatMsg({Color(120,120,255), name, Color(255,255,255), " is connecting."})
end

function GM:PlayerDisconnected(ply)
	ChatMsg({Color(120,120,255), ply:Nick(), Color(255,255,255), " has disconnected."})
	timer.Simple(0.5, GetLeader)
end 

function GM:PlayerShouldTakeDamage(ply, attacker)
	if attacker:GetClass() == "trigger_hurt" then
		return true
	end

	if ply:IsPlayer() and attacker:GetClass() != "prop_physics" then
		return false
	end
	if ply:Team() == TEAM_UNASSIGNED then
		return true
	end
	if GAMEMODE.TeamBased and ply:Team() == attacker.Owner:Team() and ply != attacker.Owner then
		return false
	else
		return true
	end
	return true
end

function GM:EntityTakeDamage(target, dmg)
	if not target:IsPlayer() then return end
	dmg:ScaleDamage(9999999)
end

function GM:PlayerDeathSound()
	// disables flatline sound
	return true
end

function GM:GetFallDamage()
	// DISABLES FUCKING ANNOYING CRUNCH FALL SOUND OF HELL
	return 0
end

function GetAlivePlayers()
	local aliveplayers = {}
	for k,v in pairs( player.GetAll() ) do
		if v:Alive() and v:Team() != 0 then table.insert( aliveplayers, v ) end
	end
	return aliveplayers or nil
end

function GetNextAlivePlayer( ply )
   local alive = GetAlivePlayers()
   
   if #alive < 1 then return nil end

   local prev = nil
   local choice = nil

   if IsValid( ply ) then
	  for k, p in pairs( alive ) do
		 if prev == ply then
			choice = p
		 end

		 prev = p
	  end
   end

   if not IsValid( choice ) then
	  choice = alive[1]
   end

   return choice
end

hook.Add("KeyPress", "speccontrols", function(ply, key)
	if ply:GetObserverMode() != 0 then
	  if key == IN_ATTACK then
		 ply:Spectate( OBS_MODE_ROAMING )
		 ply:SpectateEntity( nil )
		 local alive = GetAlivePlayers()
		 if #alive < 1 then return end
		 local target = table.Random( alive )
		 if IsValid( target ) then
			ply:SetPos( target:EyePos() )
		 end
	  elseif key == IN_ATTACK2 then
		 local target = GetNextAlivePlayer( ply:GetObserverTarget() )
		 if IsValid( target ) then
			ply:Spectate(OBS_MODE_CHASE)
			ply:SpectateEntity( target )
		 end
	  elseif key == IN_DUCK then
		 local pos = ply:GetPos()
		 local ang = ply:EyeAngles()
		 local target = ply:GetObserverTarget()
		 if IsValid( target ) and target:IsPlayer() then
			pos = target:EyePos()
			ang = target:EyeAngles()
		 end
		 ply:Spectate( OBS_MODE_ROAMING )
		 ply:SpectateEntity( nil )
		 ply:SetPos( pos )
		 ply:SetEyeAngles( ang )
		 return true
	  elseif key == IN_JUMP then
		 if not ( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
			ply:SetMoveType( MOVETYPE_NOCLIP )
		 end
	  elseif key == IN_RELOAD then
		 local tgt = ply:GetObserverTarget()
		 if not IsValid( tgt ) or not tgt:IsPlayer() then return end
			ply:SetObserverMode(OBS_MODE_IN_EYE)
		 elseif ply:GetObserverMode() == OBS_MODE_IN_EYE then
			ply:SetObserverMode(OBS_MODE_CHASE)
		 end
   end
end)

function GM:ShowTeam(ply) net.Start("pk_teamselect") net.Send(ply) end
function GM:ShowHelp(ply) net.Start("pk_helpmenu") net.Send(ply) end
function GM:ShowSpare2(ply) net.Start("pk_settingsmenu") net.Send(ply) end