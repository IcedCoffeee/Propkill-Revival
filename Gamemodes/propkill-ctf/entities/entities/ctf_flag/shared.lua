ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Flag"
ENT.Author = "Iced Coffee"
ENT.Purpose = ""

ENT.Spawnable = true
ENT.Category = "Iced Coffee"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 2, "Team")
end
