/*------------------------------------------
		Base stuff for copy-paste
------------------------------------------*/ 

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
	Msg("[Propkill]: " .. message .. "\n")
end

function shuffle(table)
	local num = #table
	for i = 1, num do
		local randnum = math.random(1, num)
		table[randnum], table[i] = table[i], table[randnum]
	end
	return table
end