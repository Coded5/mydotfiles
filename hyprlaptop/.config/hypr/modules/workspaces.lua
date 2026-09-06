for w = 1, 6 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "eDP-1",
		default = true,
		persistent = true,
	})
end

-- Workspace 1: Terminal
hl.window_rule({
	name = "workspace-1-terminal",
	match = { class = "kitty" },
	workspace = "1",
})

-- Workspace 2: Zen Browser
hl.window_rule({
	name = "workspace-2-zen",
	match = { class = "zen" },
	workspace = "2",
})

-- Workspace 3: Obsidian
hl.window_rule({
	name = "workspace-3-obsidian",
	match = { class = "md.obsidian.Obsidian" },
	workspace = "3",
})

-- Workspace 4: Discord
hl.window_rule({
	name = "workspace-3-discord",
	match = { class = "discord" },
	workspace = "4",
})


local wallpapers = {
    [1] = "~/.config/hypr/wallpapers/windmill.jpg",
    [2] = "~/.config/hypr/wallpapers/nighthaven.png",
    [3] = "~/.config/hypr/wallpapers/flowerlady.png",
    [4] = "~/.config/hypr/wallpapers/windmill.jpg",
    [5] = "~/.config/hypr/wallpapers/nighthaven.png",
    [6] = "~/.config/hypr/wallpapers/flowerlady.png",
}

hl.on("workspace.active", function(ws)
    local wp = wallpapers[ws.id]

    if wp then
        hl.exec_cmd(
            "hyprctl hyprpaper wallpaper 'eDP-1, " .. wp .. ", cover'"
        )
    end
end)
