hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@90",
	position = "0x0",
	scale = "1.5",
})

for w = 1, 8 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "eDP-1",
		default = true,
		persistent = true,
	})
end
