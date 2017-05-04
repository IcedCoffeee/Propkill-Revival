include("shared.lua")

function ENT:Draw()
	local attached = self:GetNW2Entity("Attached")
	if IsValid(attached) and attached == LocalPlayer() and not LocalPlayer():ShouldDrawLocalPlayer() then
		return
	end
	self:DrawModel()
end
