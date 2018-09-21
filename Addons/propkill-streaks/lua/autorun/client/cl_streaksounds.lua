local streakdata = {}
	streakdata.active = false
	streakdata.text = ""
	streakdata.time = 0

net.Receive("killstreakmessage", function()
	local killstreaktable = net.ReadTable()
	streakdata = {}
		streakdata.active = true
		streakdata.text = killstreaktable.text
		streakdata.time = CurTime()
		surface.PlaySound(killstreaktable.sound)
	MsgN(killstreaktable.text)
end)

function DrawStreak()
	if streakdata.active == true then
		draw.SimpleText(streakdata.text, "DermaLarge", ScrW()/2, ScrH()/6, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		if CurTime() >= streakdata.time + 3 then
			streakdata.active = false
		end
	end
end
hook.Add("HUDPaint", "KillstreakHUD", DrawStreak)