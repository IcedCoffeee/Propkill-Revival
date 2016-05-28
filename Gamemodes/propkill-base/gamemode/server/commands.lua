concommand.Add("rserver", function(ply)
	if ply:IsSuperAdmin() then
		print("Restarting server...")
		RunConsoleCommand("changelevel", game.GetMap(), "propkill")
	end
end)

function StartGame()
	// Should be overridden
end

function WarmUp()
	timer.Simple(60, function()
		StartGame()
	end)
end