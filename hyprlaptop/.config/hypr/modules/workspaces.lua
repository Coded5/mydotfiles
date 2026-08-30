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
