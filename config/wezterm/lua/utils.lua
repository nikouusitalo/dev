local wezterm = require("wezterm")

local M = {}

function M.is_windows()
	return wezterm.target_triple:find("windows") ~= nil
end

function M.get_shell()
	if M.is_windows() then
		return { "pwsh.exe", "-NoLogo" }
	end

	-- Linux / macOS: use bash
	return { "/bin/bash", "-l" }
end

return M
