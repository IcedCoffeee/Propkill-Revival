/*------------------------------------------
				F1 Propkill Help
------------------------------------------*/

function PKHelp()
	local helpframe = vgui.Create("DFrame")
	helpframe:SetSize(ScrW() - 200, ScrH() - 150)
	helpframe:Center()
	helpframe:ShowCloseButton(true)
	helpframe:SetDraggable(false)
	helpframe:SetTitle("Propkill Help")
	function helpframe:Paint(w, h)
		draw.SimpleText("Loading...", "loading_font", 870, 480, Color(255,255,255,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 170))
	end
	helpframe:MakePopup()

	local scrollpanel = vgui.Create("DScrollPanel", helpframe)
	scrollpanel:SetSize(ScrW() - 190, ScrH() - 135)
	scrollpanel:SetPos(0, 25)
	function scrollpanel:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(70, 70, 70, 170))
	end

	local html = vgui.Create("HTML", helpframe)
	html:SetPos(0, 0)
	html:Dock(FILL)
	html:OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=572479773")
end

net.Receive("pk_helpmenu", PKHelp)