-- =============================================================================
-- WINDOW RULES (hl.window_rule)
-- =============================================================================

-- Float all windows in special workspace (scratchpad)
hl.window_rule({
	match = { workspace = "special", class = "scratchpad" },
	float = true,
	size = { 800, 450 }, -- Lua tables replace space-separated numbers
})

-- Rofi rule
hl.window_rule({
	match = { class = [[(?i)\brofi\b]] },
	rounding = 0,
	focus_on_activate = true,
})

-- Ignore maximize requests from all apps
hl.window_rule({
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix dragging issues with XWayland ("wayland-dragging" block)
hl.window_rule({
	name = "wayland-dragging",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_initial_focus = true,
})

-- Picture-in-Picture for Firefox
hl.window_rule({
	name = "pip-firefox",
	match = {
		class = "^(firefox)$",
		title = "^(Picture-in-Picture)$",
	},
	float = true,
	pin = true,
	keep_aspect_ratio = true,
	size = { 800, 450 }, -- Lua tables replace space-separated numbers
})

-- Smart Gaps Window Rules (No borders/rounding when only one tiled window)
hl.window_rule({
	match = { float = false, workspace = "w[tv1]" },
	border_size = 0,
	rounding = 0,
})

hl.window_rule({
	match = { float = false, workspace = "f[1]" },
	border_size = 0,
	rounding = 0,
})

-- =============================================================================
-- LAYER RULES (hl.layer_rule)
-- =============================================================================

-- Legacy 'blurls' is fully migrated to the modern layer_rule blur effect
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "rofi" }, blur = true })

-- Animation exemptions for specific layer namespaces
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })
hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })

-- =============================================================================
-- WORKSPACE CONFIGURATIONS (hl.workspace_rule)
-- =============================================================================

-- "Smart gaps" / "No gaps when only" layout rules
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

-- Dynamically map physical monitors to workspaces 1 through 4
for w = 1, 4 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "DP-2",
		default = true,
		persistent = true,
	})
end

-- Dynamically map physical monitors to workspaces 5 through 8
for w = 5, 8 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "DP-1",
		default = true,
		persistent = true,
	})
end

hl.workspace_rule({ workspace = "special:scratchpad", on_created_empty = "foot" })

hl.window_rule({
	name = "obsidian",
	match = { class = "obsidian" },
	workspace = "special:obsidian silent",
})

hl.window_rule({
	name = "obsidian",
	match = { class = "obsidian-nvim" },
	workspace = "special:obsidian silent",
})
