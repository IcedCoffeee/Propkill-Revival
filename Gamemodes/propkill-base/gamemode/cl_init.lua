include("shared.lua")
include("client/hud.lua")
include("client/hax.lua")
include("client/scrubkeys.lua")
include("client/scoreboard.lua")
include("client/derma.lua")
include("shared/entity.lua")

// Propkill optimized defaults
RunConsoleCommand("cl_drawspawneffect", "0")
RunConsoleCommand("cl_updaterate", "1000")
RunConsoleCommand("cl_interp", "0")
RunConsoleCommand("rate", "1048576")
