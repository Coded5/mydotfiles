local mainMod = "SUPER"

-- Open terminal with mainMod + Enter
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))

-- Move focus with mainMod + HJKL
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + SHIFT + HJKL
hl.bind(mainMod .. "+ SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. "+ SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. "+ SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. "+ SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Close window
hl.bind(mainMod .. "+ C", hl.dsp.window.close())

-- ROFI
hl.bind(mainMod .. "+ F", hl.dsp.exec_cmd("rofi -show drun"))

-- Screenshot
hl.bind(mainMod .. "+ SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. "+ SHIFT + X", hl.dsp.exec_cmd("hyprshot -m window"))

-- Clipse
hl.bind(mainMod .. "+ V", hl.dsp.exec_cmd("kitty --class clipse -e 'clipse'"))

-- Switch workspace between monitors
hl.bind(mainMod .. "+ Tab", require("scripts.monitor_switch").monitor_switch)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Toggle floating
hl.bind(mainMod .. " + G", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.resize({ x = 1000, y = 600 }))
	hl.dispatch(hl.dsp.window.center())
end)

-- Restart Waybar
hl.bind(mainMod .. "+ SHIFT + R", hl.dsp.exec_cmd("killall waybar && waybar"))

-- Hyprpicker
hl.bind(mainMod .. "+ SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Toggle split
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.focus({ workspace = "special" }))
