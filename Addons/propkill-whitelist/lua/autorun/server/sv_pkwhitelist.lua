/*------------------------------------------
				Prop Whitelist
------------------------------------------*/ 

http.Fetch("http://raw.githubusercontent.com/IcedCoffeee/Propkill-Revival/master/Addons/propkill-whitelist/props.txt",
	function(body, len, headers, code)
		allowedProps = RunString(body)
	end
 )

hook.Add("PlayerSpawnProp", "propwhitelist", function(ply, model)
	local allowed = false
	for k,v in pairs(allowedProps) do
		if v == model then
			allowed = true
		end
	end
	if !allowed then return false end
end)