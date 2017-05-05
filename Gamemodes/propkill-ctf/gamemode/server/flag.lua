local flagpositions = {Vector(-1919.098267, -1552.186890, 128.031250), Vector(5279.498535, 1432.232056, 128.031250)}
GM.PickupRange = 150

function ResetFlag(ent)
	ent:SetParent(nil)
	ent:SetAngles(Angle(0,0,0))
	ent:SetNW2Entity("Attached", NULL)
	ent:SetPos(flagpositions[ent:GetTeam()])
end

function DropFlag(ent)
	ent:SetParent(nil)
	ent:SetAngles(Angle(0,0,0))
	ent:SetPos(ent:GetPos()-Vector(0,0,40))
	ent:SetNW2Entity("Attached", NULL)
end

function SpawnFlags()
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "ctf_flag" then
			v:Remove()
		end
	end
	for k,v in pairs(flagpositions) do
		local flag = ents.Create("ctf_flag")
		flag:SetPos(v)
		flag:Spawn()
		flag:SetTeam(k)
	end
end
hook.Add("InitPostEntity", "pk_spawnflags", SpawnFlags)
hook.Add("PostCleanupMap", "pk_spawnflags", SpawnFlags)

function CaptureEffects(pos, ply)
	local ed = EffectData()
	ed:SetOrigin(pos)
	util.Effect("ManhackSparks", ed, true, true)
	ply:EmitSound("buttons/blip1.wav")
end

function CaptureCheck()
	for k,v in pairs(flagpositions) do
		for j,m in pairs(ents.FindInSphere(v, GAMEMODE.PickupRange)) do
			if IsValid(m) and m:IsPlayer() and IsValid(m.Flag) and m.Flag:GetNW2Entity("Attached") == m and m.Flag:GetTeam() != k then
				AllNotify(m:Nick() .. " has captured the " .. team.GetName(m.Flag:GetTeam()) .. " flag!") -- temporary
				CaptureEffects(v, m)
				ResetFlag(m.Flag)
				team.AddScore(m:Team(), 1)
			end
		end
	end
end
hook.Add("Think", "pk_checkcapture", CaptureCheck)

function DropOnDisconnect(ply)
	if IsValid(ply.Flag) and ply.Flag:GetClass() == "ctf_flag" then
		DropFlag(ply.Flag)
	end
end
hook.Add("PlayerDisconnected", "pk_dropflagdisconnect", DropOnDisconnect)
