function PK_DuelHUD()
	if GetGlobalBool("PK_Dueling") then
		draw.SimpleText(GetGlobalInt("PK_ply1_score") .. "-" .. GetGlobalInt("PK_ply2_score"), "spec_font1", ScrW()/2, ScrH()/6, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end
hook.Add("HUDPaint", "PK_Duel_HUD", PK_DuelHUD)