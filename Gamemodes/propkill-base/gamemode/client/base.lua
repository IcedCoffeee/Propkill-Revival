net.Receive("pk_chatmsg", function(len) 
	chat.AddText(unpack(net.ReadTable()))
end)

net.Receive("pk_notify", function()
	local msg = net.ReadString()
	notification.AddLegacy(msg, NOTIFY_GENERIC, 3)
	surface.PlaySound("buttons/button2.wav")
end)

net.Receive("pk_gamenotify", function()
	hudmsg = net.ReadString()
	local time = net.ReadInt(16)
	timer.Create("hudmsg", time, 1, function() end)
end)

function KilledByProp()
	local ply	   = net.ReadEntity()
	local inflictor = net.ReadString()
	local attacker  = net.ReadEntity()

	if !attacker:IsPlayer() then
		GAMEMODE:AddDeathNotice(nil, 0, "suicide", ply:Name(), ply:Team())
		return
	end

	GAMEMODE:AddDeathNotice(attacker:Name(), attacker:Team(), inflictor, ply:Name(), ply:Team())
end

net.Receive("KilledByProp", KilledByProp)

hook.Add("PreDrawSkyBox", "removeSkybox", function()
	render.Clear(50, 50, 50, 255)
	return true
end)
