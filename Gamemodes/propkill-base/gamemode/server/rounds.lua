function StartWarmup()
	timer.Create("pk_warmuptimer", 30, 1, EndWarmup)
end

function EndWarmup()

end

hook.Add("Initialize", "pk_startroundtimers", asd)
