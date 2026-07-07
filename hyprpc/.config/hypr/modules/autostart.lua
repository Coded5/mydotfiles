hl.on("hyprland.start", function()
	-- Native systemd management (No UWSM prefix needed)
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	-- Session-managed applications and daemons
	hl.exec_cmd("uwsm app -- otd-daemon")
	hl.exec_cmd("uwsm app -- nm-applet")
	hl.exec_cmd("uwsm app -- waybar")
	hl.exec_cmd("uwsm app -- hyprpaper")
	hl.exec_cmd("uwsm app -- clipse -listen")
	hl.exec_cmd("uwsm app -- obsidian")
end)
