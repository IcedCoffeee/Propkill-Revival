function TDMHUD()
	local playing = GetGlobalBool("TDM_Playing")
	if playing then
		draw.SimpleText(team.GetScore(1) .. "-" .. team.GetScore(2), "ltb24", ScrW() / 2 - 50, ScrH() - 70, Color(255, 255, 255, 200), 0, 0)
		draw.SimpleText(GetGlobalInt("TDM_Time_Left"), "ltb24", ScrW() / 2 - 50, 10, Color(255, 255, 255, 200), 0, 0)
	end
end
hook.Add("HUDPaint", "TDMHUD", TDMHUD)
