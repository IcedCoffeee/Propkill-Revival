pk_leaderboard = {}
pk_matchhistory = {}

function PK_UpdateLeaderboard()
	print("Attempting update...")
	http.Fetch("http://139.99.192.232:8880/api/leaderboard",
		function(body, len, headers, code)
			pk_leaderboard = util.JSONToTable(body)
			print("Updated leaderboard!")
		end,
		function(error)
			print("Failed to update leaderboard! Error: " .. error)
		end
	)
end

net.Receive("pk_leaderboard", function(len, ply)
	net.Start("pk_leaderboard")
		net.WriteTable(pk_leaderboard)
	net.Send(ply)
end)

function PK_UpdateMatchHistory()
	print("Attempting update...")
	http.Fetch("http://139.99.192.232:8880/api/matchhistory",
		function(body, len, headers, code)
			pk_matchhistory = util.JSONToTable(body)
			print("Updated match history!")
		end,
		function(error)
			print("Failed to update match history! Error: " .. error)
		end
	)
end

net.Receive("pk_matchhistory", function(len, ply)
	net.Start("pk_matchhistory")
		net.WriteTable(pk_matchhistory)
	net.Send(ply)
end)

function uploadMatchResult(results)
	jsonResults = util.TableToJSON(results)
	tbl = {
		["serverKey"] = "abcdef123",
		["matchResults"] = jsonResults
	}
	PrintTable(tbl)
	http.Post("http://139.99.192.232:8880/api/matchresult", tbl,
		function(responseText, contentLength, responseHeaders, statusCode)
			ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Match result saved!", " Code: ", tostring(statusCode)})
			print(responseText)
			print(contentLength)
			print(responseHeaders)
			print(statusCode)
		end,
		function(errorMessage)
			ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Error uploading match result, see console!"})
			print(errorMessage)
		end
	)
	timer.Create("PK_Delayed_Update_Leaderboard", 3, 1, PK_UpdateLeaderboard)
	timer.Create("PK_Delayed_Update_MatchHistory", 3, 1, PK_UpdateMatchHistory)
end

function _testUploadMatchResult(results)
	jsonResults = util.TableToJSON({
		["winner"] = {["steamid"] = "STEAM_0:0:0000001", ["score"] = 15},
		["loser"] = {["steamid"] = "STEAM_0:0:0000002", ["score"] = 0}
	})
	tbl = {
		["serverKey"] = "abcdef123",
		["matchResults"] = jsonResults
	}
	PrintTable(tbl)
	http.Post("http://139.99.192.232:8880/api/matchresult", tbl,
		function(responseText, contentLength, responseHeaders, statusCode)
			ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Match result saved!", " Code: ", tostring(statusCode)})
			print(responseText)
			print(contentLength)
			print(responseHeaders)
			print(statusCode)
		end,
		function(errorMessage)
			ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Error uploading match result, see console!"})
			print(errorMessage)
		end
	)
	timer.Create("PK_Delayed_Update_Leaderboard", 3, 1, PK_UpdateLeaderboard)
	timer.Create("PK_Delayed_Update_MatchHistory", 3, 1, PK_UpdateMatchHistory)
end

timer.Create("PK_Update_Leaderboard_Periodically", 300, 0, function()
	PK_UpdateLeaderboard()
	PK_UpdateMatchHistory()
end)

PK_UpdateLeaderboard()
PK_UpdateMatchHistory()