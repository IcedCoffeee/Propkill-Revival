function GetAllFlags()
	local tbl = {}
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "ctf_flag" and IsValid(v) then
			table.insert(tbl, v)
		end
	end
	return tbl
end

function PropkillCTFHUD()
	for k,v in pairs(GetAllFlags()) do
		if v:GetNW2Entity("Attached") == LocalPlayer() and IsValid(v) then
			draw.RoundedBox(3, 310, ScrH() - 35, 300, 33, Color(24, 24, 24, 150))
			draw.SimpleText("You have the flag!", "stb24", 315, ScrH() - 30, Color(255, 255, 255, 200), 0, 0)
		end
	end
end
hook.Add("HUDPaint", "pk_ctf_hud", PropkillCTFHUD)