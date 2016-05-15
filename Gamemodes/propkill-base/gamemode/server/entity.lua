function GM:PlayerSpawnedProp(ply, model, ent) 
	ent.Owner = ply
end


function GM:PhysgunPickup( ply, ent )
	if ent.Owner == nil then
		ent.Owner = ply
	end
	if ent:IsPlayer() or ent.Owner ~= ply then return false end
	return true
end 

function GM:OnPhysgunReload() return false end
function GM:PlayerSpawnSENT(ply) ply:SendLua("GAMEMODE:AddNotify(\"You can only spawn props!\", NOTIFY_GENERIC, 3)") ply:SendLua("surface.PlaySound('buttons/button2.wav')") return false end
function GM:PlayerSpawnSWEP(ply) ply:SendLua("GAMEMODE:AddNotify(\"You can only spawn props!\", NOTIFY_GENERIC, 3)") ply:SendLua("surface.PlaySound('buttons/button2.wav')") return false end
function GM:PlayerGiveSWEP(ply) ply:SendLua("GAMEMODE:AddNotify(\"You can only spawn props!\", NOTIFY_GENERIC, 3)") ply:SendLua("surface.PlaySound('buttons/button2.wav')") return false end
function GM:PlayerSpawnEffect(ply) ply:SendLua("GAMEMODE:AddNotify(\"You can only spawn props!\", NOTIFY_GENERIC, 3)") ply:SendLua("surface.PlaySound('buttons/button2.wav')") return false end
function GM:PlayerSpawnVehicle(ply) ply:SendLua("GAMEMODE:AddNotify(\"You can only spawn props!\", NOTIFY_GENERIC, 3)") ply:SendLua("surface.PlaySound('buttons/button2.wav')") return false end
function GM:PlayerSpawnNPC(ply) ply:SendLua("GAMEMODE:AddNotify(\"You can only spawn props!\", NOTIFY_GENERIC, 3)") ply:SendLua("surface.PlaySound('buttons/button2.wav')") return false end 
function GM:PlayerSpawnRagdoll(ply) ply:SendLua("GAMEMODE:AddNotify(\"You can only spawn props!\", NOTIFY_GENERIC, 3)") ply:SendLua("surface.PlaySound('buttons/button2.wav')") return false end
function GM:PlayerSpawnProp(ply, model)
	if model == "models/props/de_tides/gate_large.mdl" and GetGlobalBool("PK_LockersOnly") == true then
		ply:SendLua("GAMEMODE:AddNotify(\"Lockers only is enabled!\", NOTIFY_GENERIC, 6)")
		ply:SendLua("surface.PlaySound('buttons/button2.wav')")
		return false
	end

	if ply:Team() == TEAM_UNASSIGNED then
		ply:SendLua("GAMEMODE:AddNotify(\"You can't spawn props as a Spectator!\", NOTIFY_GENERIC, 3)")
		ply:SendLua("surface.PlaySound('buttons/button2.wav')")
		return false
	else
		return true
	end
end	

function GM:InitPostEntity()
	local physData = physenv.GetPerformanceSettings()
	physData.MaxVelocity = 2000
	physData.MaxAngularVelocity = 3636
	physenv.SetPerformanceSettings(physData)
		game.ConsoleCommand("sv_allowcslua 1\n")
		game.ConsoleCommand("physgun_DampingFactor 0.9\n")
		game.ConsoleCommand("sv_airaccelerate 1000\n")
		game.ConsoleCommand("sv_sticktoground 0\n")
end