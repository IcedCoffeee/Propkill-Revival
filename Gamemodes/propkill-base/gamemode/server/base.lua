cwhite = Color(255,255,255)
cgrey = Color(200,200,200)

function ChatMsg(message)
	net.Start("pk_chatmsg")
		net.WriteTable(message)
	net.Broadcast() 
end

function NotifyAll(message)
	for k,v in pairs(player.GetAll()) do
		net.Start("pk_notify")
			net.WriteString(message)
		net.Send(v)
	end
end

function GameNotify(message, time)
	if time == nil then time = 3 end
	net.Start("pk_gamenotify")
		net.WriteString(message)
		net.WriteInt(time, 16)
	net.Broadcast()
end

function TeamNotify(t, message, time)
	if time == nil then time = 3 end
	for k,v in pairs(team.GetPlayers(t)) do
		net.Start("pk_gamenotify")
			net.WriteString(message)
			net.WriteInt(time, 16)
		net.Send(v)
	end
end

function LogPrint(message)
	MsgC(cwhite, "[Propkill]: ", cgrey, message .. "\n")
end

function Notify(ply, message)
	net.Start("pk_notify")
		net.WriteString(message)
	net.Send(ply)
end

function shuffle(table)
	local num = #table
	for i = 1, num do
		local randnum = math.random(1, num)
		table[randnum], table[i] = table[i], table[randnum]
	end
	return table
end
