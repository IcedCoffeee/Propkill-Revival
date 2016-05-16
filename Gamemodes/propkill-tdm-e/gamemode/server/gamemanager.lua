/*------------------------------------------
				Game Manager
------------------------------------------*/

function StartGame()
	for k,v in pairs(player.GetAll()) do
		v:Respawn()
		v:Freeze(true)
	end
	timer.Simple(3, function()
		for k,v in pairs(player.GetAll()) do
			v:Freeze(false)
		end
	end)
end