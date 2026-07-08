return function()
	hl.exec_cmd("uwsm app -- otd-daemon")
	hl.exec_cmd("uwsm app -- clipse -listen")
	hl.exec_cmd("uwsm app -- obsidian")
end
