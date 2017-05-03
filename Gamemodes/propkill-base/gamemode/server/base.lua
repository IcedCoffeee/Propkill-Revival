/*------------------------------------------
		Base stuff for copy-paste
------------------------------------------*/ 

cwhite = Color(255,255,255)
cgrey = Color(200,200,200)

function ChatMsg(message)
	net.Start("chatmsg")
		net.WriteTable(message)
	net.Broadcast() 
end

function AllNotify(message)
	for k,v in pairs(player.GetAll()) do
		v:SendLua("GAMEMODE:AddNotify(\"" .. message .. "\", NOTIFY_GENERIC, 6)")
	end
end

function LogPrint(message)
	MsgC(cwhite, "[Propkill]: ", cgrey, message .. "\n")
end

function Notify(ply, message)
	ply:SendLua("GAMEMODE:AddNotify(\"" .. message .. "\", NOTIFY_GENERIC, 3)")
	ply:SendLua("surface.PlaySound('buttons/button2.wav')")
end

function shuffle(table)
	local num = #table
	for i = 1, num do
		local randnum = math.random(1, num)
		table[randnum], table[i] = table[i], table[randnum]
	end
	return table
end