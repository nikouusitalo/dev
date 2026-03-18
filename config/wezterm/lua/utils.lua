local wezterm = require("wezterm")

local M = {}

function M.is_windows()
	return wezterm.target_triple:find("windows") ~= nil
end

function M.get_home_dir()
	return wezterm.home_dir or os.getenv("HOME") or "~"
end

function M.get_shell()
	if M.is_windows() then
		return { "pwsh.exe", "-NoLogo" }
	end

	-- Linux / macOS: use bash
	return { "/bin/bash", "-l" }
end

function M.get_shell_with_command(command)
	if M.is_windows() then
		return { "pwsh.exe", "-NoLogo", "-Command", command }
	end

	return { "/bin/bash", "-lc", command }
end

return M
