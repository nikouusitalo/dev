local M = {}

local modules = {
	function(window, _)
		local ws = window:active_workspace()
		return "󰕰  " .. ws
	end,
	function()
		-- Näytä kellonaika
		return os.date("  %H:%M")
	end,
}

function M.setup(config)
	wezterm.on("update-right-status", function(window, pane)
		local parts = {}

		for _, mod in ipairs(modules) do
			local ok, result = pcall(mod, window, pane)
			if ok and result then
				table.insert(parts, result)
			end
		end

		window:set_right_status(wezterm.format({
			{ Text = " " .. table.concat(parts, "  |  ") .. " " },
		}))
	end)
end

return M
