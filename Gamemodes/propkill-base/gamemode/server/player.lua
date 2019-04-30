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

function GM:PlayerSetModel(ply)
	local cl_playermodel = ply:GetInfo("cl_playermodel")
	local modelname = player_manager.TranslatePlayerModel(cl_playermodel)
	util.PrecacheModel(modelname)
	ply:SetModel(modelname)

	local col = ply:GetInfo("cl_playercolor")
	ply:SetPlayerColor(Vector(col))
end

local function PK_PlayerLoadout(ply)
	if ply:Team() != TEAM_UNASSIGNED then
		ply:SetHealth(1)
		ply:Give("weapon_physgun")
	end

	local col = ply:GetInfo("cl_weaponcolor")
	ply:SetWeaponColor(Vector(col))
end
hook.Add("PlayerLoadout", "PK_PlayerSpawn", PK_PlayerLoadout)


function GM:PlayerSpawn(ply)
	if ply:Team() == TEAM_UNASSIGNED then
		ply:StripWeapons()
		GAMEMODE:PlayerSpawnAsSpectator(ply)
	else
		ply:UnSpectate()
	end

	ply.temp = 0
	ply.streak = 0
	ply:SetWalkSpeed(400)
	ply:SetRunSpeed(400)
	ply:SetJumpPower(200)

	hook.Call("PlayerLoadout", GAMEMODE, ply)
	hook.Call("PlayerSetModel", GAMEMODE, ply)
	ply:SetupHands()
end

function GM:OnPlayerChangedTeam(ply, old, new)
	ChatMsg({team.GetColor(old), ply:Nick(), cwhite, " has joined team ", team.GetColor(new), team.GetName(new), "!"})
	ply.NextSpawnTime = CurTime()
end

hook.Add("PlayerDeath", "PK_PlayerDeath", function(ply, inflictor, attacker)
	ply.NextSpawnTime = CurTime() + 1
	
	GetLeader()
end)

function GM:PlayerConnect(name, ip)
	ChatMsg({Color(120,120,255), name, Color(255,255,255), " is connecting."})
end

function GM:PlayerDisconnected(ply)
	ChatMsg({Color(120,120,255), ply:Nick(), Color(255,255,255), " has disconnected."})
	timer.Simple(0.5, GetLeader)
end 

hook.Add("PlayerShouldTakeDamage", "PK_PlayerShouldTakeDamage", function(ply, attacker)
	if ply:Team() == TEAM_UNASSIGNED then
		return false
	end

	if attacker:IsPlayer() then
		if attacker:Team() == TEAM_UNASSIGNED then
			return false
		end

		if GAMEMODE.TeamBased and attacker:Team() == ply:Team() then
			return false
		end
	else
		if attacker:GetClass() == "trigger_hurt" then
			return true
		end
	end
end)

function GM:EntityTakeDamage(target, dmg)
	local inflictor = dmg:GetInflictor()

	if not target:IsPlayer() then return end
	if inflictor == game.GetWorld() then return end // TODO: find closest prop if world damages

	if IsValid(inflictor) and IsValid(inflictor.Owner) and inflictor.Owner:IsPlayer() then
		dmg:SetAttacker(inflictor.Owner)
	end

	dmg:AddDamage(target:Health()+10000)
end

// disable flatline sound
function GM:PlayerDeathSound()
	return true
end

// disable fall crunch and damage
function GM:GetFallDamage()
	return 0
end

// TODO: move to client
function GetAlivePlayers()
	local aliveplayers = {}
	for k,v in pairs( player.GetAll() ) do
		if v:Alive() and v:Team() != 0 then table.insert( aliveplayers, v ) end
	end
	return aliveplayers or nil
end

// TODO: move to client
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

// TODO: move to client
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
