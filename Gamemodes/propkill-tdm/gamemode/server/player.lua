function GM:PlayerInitialSpawn(ply)
	if (!ply:IsBot()) then
		net.Start("teamselect")
		net.Send(ply)
		ply:SetTeam(3)
		else
		ply:SetTeam(1)
	end
	ply.temp = 0
end

function GM:PlayerSpawn(ply)
	if (ply:Team() == 0) then
		ply:StripWeapons()
		ply:Spectate(OBS_MODE_ROAMING)
		return true
	else
		ply:UnSpectate()
	end
	ply.temp = 0
	ply:SetHealth(1)
	ply:SetJumpPower(200)
	ply:Give("weapon_physgun")
	ply:SetModel("models/player/alyx.mdl")

	local col = ply:GetInfo("cl_playercolor")
	ply:SetPlayerColor(Vector(col))

	local col = ply:GetInfo("cl_weaponcolor")
	ply:SetWeaponColor(Vector(col))
end

function GM:ShowTeam(ply) net.Start("teamselect") net.Send(ply) end
function GM:ShowHelp(ply) net.Start("helpmenu") net.Send(ply) end