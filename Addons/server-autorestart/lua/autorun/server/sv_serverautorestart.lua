-- Automatically restarts the server at 6AM if there are no players

hook.Add("InitPostEntity", "sv_autorestart", function()
	timer.Create("sv_autorestart", math.abs(os.date("%H")-6)*60*60, 1, function()
		if #player.GetAll() == 0 then
			RunConsoleCommand("changelevel", game.GetMap(), engine.ActiveGamemode())
		end
	end)
end)