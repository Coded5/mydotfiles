local M = {}

function M:monitor_switch()
	local current = hl.get_active_monitor()
	local monitors = hl.get_monitors() or {}

	if current == nil then
		return
	end

	for _, mon in ipairs(monitors) do
		-- Find the first monitor that isn't the currently focused one
		if mon.id ~= current.id then
			local other_ws = hl.get_active_workspace(mon.id)
			if other_ws then
				hl.dispatch(hl.dsp.focus({ workspace = other_ws.id }))
			end
			break
		end
	end
end

return M
