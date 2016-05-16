function GM:ShowTeam(ply) net.Start("teamselect") net.Send(ply) end
function GM:ShowHelp(ply) net.Start("helpmenu") net.Send(ply) end