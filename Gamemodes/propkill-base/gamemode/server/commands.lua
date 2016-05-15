concommand.Add("rserver", function(ply)
	if ply:IsSuperAdmin() then
		print("Restarting server...")
		RunConsoleCommand("changelevel", game.GetMap(), "propkill")
	end
end)

concommand.Add("pk_180", function(ply)
	local a = ply:EyeAngles()
	ply:SetEyeAngles(Angle(a.p, a.y-180, a.r))
end)

concommand.Add("pk_180up", function(ply)
	local a = ply:EyeAngles() ply:SetEyeAngles(Angle(a.p-a.p-a.p, a.y-180, a.r))
	ply:ConCommand("+jump")
	timer.Simple(0.2, function() ply:ConCommand("-jump") end)
end)