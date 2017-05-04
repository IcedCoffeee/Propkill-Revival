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
			if v:GetPos():Distance(self.Entity:GetPos()) < GAMEMODE.PickupRange and v:Team() != self:GetTeam() and v:Alive() then
				self.Entity:SetParent(v, 18)
				self.Entity:SetPos(v:GetPos()+Vector(0,0,100))
				self:SetNW2Entity("Attached", v)
				v.Flag = self
			end
			if v:GetPos():Distance(self.Entity:GetPos()) < GAMEMODE.PickupRange and v:Team() == self:GetTeam() and v:Alive() then
				ResetFlag(self.Entity)
			end
		end
	else
		if not attached:Alive() then
			self.Entity:SetParent(nil)
			self.Entity:SetAngles(Angle(0,0,0))
			self:SetNW2Entity("Attached", NULL)
			attached.Flag = NULL
		end
	end
end
