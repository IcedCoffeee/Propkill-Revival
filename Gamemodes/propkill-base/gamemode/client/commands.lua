function UseLerpCommand(ply, cmd, args)
	if tonumber(args[1]) == 1 then
		RunConsoleCommand("cl_updaterate", "1000")
		RunConsoleCommand("cl_interp", "0")
		RunConsoleCommand("rate", "1048576")
	elseif tonumber(args[1]) < 1 then
		RunConsoleCommand("cl_updaterate", "30")
		RunConsoleCommand("cl_interp", "0.1")
		RunConsoleCommand("rate", "30000")
	end
end
concommand.Add("pk_cl_physics", UseLerpCommand)

