function GM:PlayerInitialSpawn(ply)
	ply:SetTeam(TEAM_DEATHMATCH)
	ply.temp = 0
end

function GM:PlayerSpawn(ply)
	if (ply:Team() == TEAM_UNASSIGNED) then
		ply:StripWeapons()
		ply:Spectate(OBS_MODE_ROAMING)
		return true
	else
		ply:UnSpectate()
	end

	ply.temp = 0
	ply:SetHealth(1)
	ply:SetWalkSpeed(400)
	ply:SetRunSpeed(400)
	ply:SetJumpPower(200)
	ply:Give("weapon_physgun")
	ply:SetModel("models/player/alyx.mdl")

	local col = ply:GetInfo("cl_playercolor")
	ply:SetPlayerColor(Vector(col))

	local col = ply:GetInfo("cl_weaponcolor")
	ply:SetWeaponColor(Vector(col))
end

function GM:ShowTeam(ply) net.Start("pk_teamselect") net.Send(ply) end
function GM:ShowHelp(ply) net.Start("pk_helpmenu") net.Send(ply) end