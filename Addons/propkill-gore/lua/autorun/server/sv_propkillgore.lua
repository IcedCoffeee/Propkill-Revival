sound.Add( {
	name = "pkgoresound", 
	channel = CHAN_BGO+2, 
	volume = 1.0, 
	level = SNDLVL_80dB, 
	pitch = { 95, 105 }, 
	sound = {
		"kf2_tear1.wav",
		"kf2_tear2.wav",
		"kf2_tear3.wav",
		"kf2_tear4.wav",
		"kf2_tear5.wav",
		"kf2_tear6.wav",
		"kf2_tear7.wav",
		"kf2_tear8.wav",
	}
} )

hook.Add("PlayerDeath", "pk_gore", function(ply)
	local x = ply:GetPos().x
	local y = ply:GetPos().y
	local z = ply:GetPos().z
	BroadcastLua("util.Decal(\"Blood\", Vector(" .. x .. "," .. y .. "," .. z .. "), Vector(" .. x .. "," .. y .. "," .. z .. ") - Vector(0, 0, 100))")
	sound.Play("pkgoresound", ply:GetPos())
end)