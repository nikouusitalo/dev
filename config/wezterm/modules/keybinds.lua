local wezterm = require("wezterm")
local sessionizer = require("modules.sessionizer")

local M = {}

M.keys = {
	{
		key = "f",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			sessionizer.toggle(window, pane)
		end),
	},
}

return M
