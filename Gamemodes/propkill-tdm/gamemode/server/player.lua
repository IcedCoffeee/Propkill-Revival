function GM:PlayerInitialSpawn(ply)
	ply:SetTeam(TEAM_UNASSIGNED)
	ply.temp = 0
end

function GM:ShowTeam(ply) net.Start("teamselect") net.Send(ply) end
function GM:ShowHelp(ply) net.Start("helpmenu") net.Send(ply) end