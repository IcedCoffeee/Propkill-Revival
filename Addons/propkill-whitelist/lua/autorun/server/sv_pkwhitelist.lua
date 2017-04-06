/*------------------------------------------
				Prop Whitelist
------------------------------------------*/ 

// backup in case github is down for whatever reason
allowedProps = {
	"models/props_phx/wheels/moped_tire.mdl",
	"models/props/de_tides/gate_large.mdl",
	"models/props/de_inferno/chimney01.mdl",
	"models/props_junk/sawblade001a.mdl",
	"models/props/CS_militia/refrigerator01.mdl",
	"models/XQM/CoasterTrack/slope_225_4.mdl",
	"models/props_c17/Lockers001a.mdl",
	"models/props_phx/construct/metal_plate4x4.mdl",
	"models/props_lab/blastdoor001c.mdl",
	"models/props/de_inferno/flower_barrel_p11.mdl",
	"models/props/de_inferno/flower_barrel_p10.mdl",
	"models/XQM/CoasterTrack/slope_225_3.mdl",
	"models/XQM/CoasterTrack/slope_225_2.mdl",
}

propWhiteListEnabled = false

http.Fetch("http://raw.githubusercontent.com/IcedCoffeee/Propkill-Revival/master/Addons/propkill-whitelist/props.txt",
	function(body, len, headers, code)
		RunString(body)
	end,
	function(error)
		print("Could not fetch props.txt whitelist. Error: " .. error)
	end
)

function FetchPropWhitelist(ply)
	if !ply:IsSuperAdmin() then return false end
	LogPrint("Fetching prop whitelist by player command...")
	http.Fetch("http://raw.githubusercontent.com/IcedCoffeee/Propkill-Revival/master/Addons/propkill-whitelist/props.txt",
		function(body, len, headers, code)
			RunString(body)
		end,
		function(error)
			print("Could not fetch props.txt whitelist. Error: " .. error)
		end
	)
end
concommand.Add("pk_fetchpropwhitelist", FetchPropWhitelist)

function TogglePropWhitelist(ply)
	if !ply:IsSuperAdmin() then return false end
	propWhiteListEnabled = !propWhiteListEnabled
	if propWhiteListEnabled then
		print("PK Prop Whitelist enabled")
	else
		print("PK Prop Whitelist disabled")
	end
end
concommand.Add("pk_propwhitelist", TogglePropWhitelist)

hook.Add("PlayerSpawnProp", "propwhitelist", function(ply, model)
	if propWhiteListEnabled then
		local allowed = false
		for k,v in pairs(allowedProps) do
			if v == model then
				allowed = true
			end
		end
		if !allowed then return false end
	end
end)