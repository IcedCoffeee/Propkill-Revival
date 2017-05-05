hook.Add("PlayerSpawnedProp", "pk_setpropowner", function(ply, model, ent) 
	ent.Owner = ply
	ent:SetNW2Entity("Owner", ply)
end)

function GM:OnPhysgunReload() return false end
function GM:PlayerSpawnSENT(ply) Notify(ply, "You can only spawn props!") return false end
function GM:PlayerSpawnSWEP(ply) Notify(ply, "You can only spawn props!") return false end
function GM:PlayerGiveSWEP(ply) Notify(ply, "You can only spawn props!") return false end
function GM:PlayerSpawnEffect(ply) Notify(ply, "You can only spawn props!") return false end
function GM:PlayerSpawnVehicle(ply) Notify(ply, "You can only spawn props!") return false end
function GM:PlayerSpawnNPC(ply) Notify(ply, "You can only spawn props!") return false end 
function GM:PlayerSpawnRagdoll(ply) Notify(ply, "You can only spawn props!") return false end

hook.Add("PlayerSpawnProp", "pk_canspawnprop", function(ply, model)
	if not ply:Alive() then
		return false
	end
	if model == "models/props/de_tides/gate_large.mdl" and GetGlobalBool("PK_LockersOnly") == true then
		Notify(ply, "Lockers only is enabled!")
		return false
	end

	if ply:Team() == TEAM_UNASSIGNED then
		Notify(ply, "You can't spawn props as a Spectator!")
		return false
	end
end)

function GM:InitPostEntity()
	local physData = physenv.GetPerformanceSettings()
	physData.MaxVelocity = 2200
	physData.MaxAngularVelocity = 3636
	physenv.SetPerformanceSettings(physData)
		game.ConsoleCommand("sv_allowcslua 1\n")
		game.ConsoleCommand("physgun_DampingFactor 0.9\n")
		game.ConsoleCommand("sv_airaccelerate 1000\n")
		game.ConsoleCommand("sv_sticktoground 0\n")
end
