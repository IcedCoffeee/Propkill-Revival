include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

function ENT:Initialize()
	self:SetModel("models/props_trainstation/TrackSign03.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:PhysicsInit(SOLID_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetUseType(SIMPLE_USE)
	self:DrawShadow(true)
	self:SetNW2Entity("Attached", NULL)
	self:SetTeam(0)
end

function ENT:Think()
	local attached = self:GetNW2Entity("Attached")

	if not IsValid(attached) and not IsValid(attached.Flag) then
		for k,v in pairs(player.GetAll()) do
			if v:GetPos():Distance(self.Entity:GetPos()) < GAMEMODE.PickupRange and v:Team() != self:GetTeam() and v:Alive() and v:Team() != TEAM_UNASSIGNED then
				self.Entity:SetParent(v, 18)
				self.Entity:SetPos(v:GetPos()+Vector(0,0,100))
				self:SetNW2Entity("Attached", v)
				v.Flag = self
				self:EmitSound("buttons/latchunlocked2.wav")
				TeamNotify(self:GetTeam(), "Enemy team has your flag")
				TeamNotify(v:Team(), "Your team has the flag")
			end
			if v:GetPos():Distance(self.Entity:GetPos()) < GAMEMODE.PickupRange and v:Team() == self:GetTeam() and v:Alive() then
				if not IsFlagHome(self.Entity) then
					ResetFlag(self.Entity)
					GameNotify(team.GetName(self:GetTeam()) .. " flag returned")
				end
			end
		end
		if not util.IsInWorld(self.Entity:GetPos()) then
			ResetFlag(self.Entity)
		end
	else
		if not attached:Alive() then
			DropFlag(self.Entity)
			attached.Flag = NULL
			TeamNotify(self:GetTeam(), "Your flag has been dropped")
			TeamNotify(attached:Team(), "Enemy flag dropped")
		end
	end

	if self:GetPos() == Vector(0,0,0) then
		ResetFlag(self.Entity)
	end

	self:NextThink(CurTime()+0.05)
	return true
end
