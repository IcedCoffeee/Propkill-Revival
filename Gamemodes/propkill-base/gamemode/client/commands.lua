pk_leaderboard = {}

function PK_RequestLeaderboard()
	net.Start("pk_leaderboard")
	net.SendToServer()
	print("Requesting leaderboard...")
end

net.Receive("pk_leaderboard", function()
	pk_leaderboard = net.ReadTable()
	print("Leaderboard updated!")
end)