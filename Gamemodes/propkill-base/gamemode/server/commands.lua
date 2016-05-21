concommand.Add("rserver", function(ply)
	if ply:IsSuperAdmin() then
		print("Restarting server...")
		RunConsoleCommand("changelevel", game.GetMap(), "propkill")
	end
end)