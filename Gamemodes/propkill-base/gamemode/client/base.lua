net.Receive("pk_chatmsg", function(len) 
	chat.AddText(unpack(net.ReadTable()))
end)

net.Receive("pk_notify", function()
	local msg = net.ReadString()
	notification.AddLegacy(msg, NOTIFY_GENERIC, 3)
	surface.PlaySound("buttons/button2.wav")
end)

function KilledByProp()
	local ply	   = net.ReadEntity()
	local inflictor = net.ReadString()
	local attacker  = net.ReadEntity()

	GAMEMODE:AddDeathNotice(attacker:Name(), attacker:Team(), inflictor, ply:Name(), ply:Team())
end

net.Receive("KilledByProp", KilledByProp)

hook.Add("PreDrawSkyBox", "removeSkybox", function()
	render.Clear(50, 50, 50, 255)
	return true
end)
