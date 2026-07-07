for w = 1, 8 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "eDP-1",
		default = true,
		persistent = true,
	})
end
