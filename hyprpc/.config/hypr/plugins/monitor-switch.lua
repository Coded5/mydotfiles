local mainMod = "SUPER"

local LEFT = "DP-2"
local RIGHT = "DP-1"

hl.bind(mainMod .. "+ Q", hl.dsp.focus({ monitor = LEFT }))
hl.bind(mainMod .. "+ E", hl.dsp.focus({ monitor = RIGHT }))

for i = 1, 4 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = "m~" .. i }))

	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = "m~" .. i }))
end
