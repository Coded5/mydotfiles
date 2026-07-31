for w = 1, 4 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "DP-1",
		default = true,
		persistent = true,
	})
end

for w = 5, 8 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "DP-2",
		default = true,
		persistent = true,
	})
end
