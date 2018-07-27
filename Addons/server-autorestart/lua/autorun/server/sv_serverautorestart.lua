-- Automatically restarts the server at 1AM if there are no players

timer.Create("sv_autorestart", (os.date("*t").hour-25)*60*60, 1, function()
	if #player.GetAll() > 0 then
		RunConsoleCommand("changelevel", game.GetMap(), engine.ActiveGamemode())
	end
end)