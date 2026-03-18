local wezterm = require("wezterm")
local projects = require("projects")
local utils = require("lua.utils")
local act = wezterm.action

local function notify(window, title, message)
	window:toast_notification(title, message, nil, 4000)
end

local function get_fzf_command()
	if utils.is_windows() then
		return nil
	end

	return [[
selection="$(fzf)"
if [ -n "$selection" ]; then
	exec nvim "$selection"
fi
exec /bin/bash -l
]]
end

local function get_fzf_open_dir_command()
	if utils.is_windows() then
		return nil
	end

	return [[
selection="$(
	find . \
		-path '*/.git' -prune -o \
		-path '*/node_modules' -prune -o \
		-path '*/.direnv' -prune -o \
		-type d -print | fzf
)"
if [ -n "$selection" ]; then
	cd "$selection" || exit 1
fi
exec /bin/bash -l
]]
end

local function get_pane_cwd(pane)
	local cwd_uri = pane:get_current_working_dir()
	if type(cwd_uri) == "table" and cwd_uri.file_path then
		return cwd_uri.file_path
	end

	return nil
end

local function perform_open_tab(window, pane, title, opts)
	local mux_window = window:mux_window()
	local tab = mux_window:spawn_tab(opts)
	tab:set_title(title)
end

local function spawn_shell_command(window, pane, title, command)
	if not command then
		notify(window, title, "Not implemented on Windows yet")
		return
	end

	perform_open_tab(window, pane, title, {
		cwd = get_pane_cwd(pane),
		args = utils.get_shell_with_command(command),
	})
end

local function open_fzf_action()
	local command = get_fzf_command()

	return wezterm.action_callback(function(window, pane)
		spawn_shell_command(window, pane, "fzf", command)
	end)
end

local function open_fzf_directory()
	local command = get_fzf_open_dir_command()

	return wezterm.action_callback(function(window, pane)
		spawn_shell_command(window, pane, "dirs", command)
	end)
end

local function get_projects_choices()
	local choices = {}
	for _, project in ipairs(projects) do
		table.insert(choices, { label = project.id .. " - " .. project.name, id = project.id })
	end

	return choices
end

local function get_project_by_id(id)
	for _, project in ipairs(projects) do
		if project.id == id then
			return project
		end
	end

	return nil
end

local function select_project()
	local choices = get_projects_choices()

	return wezterm.action_callback(function(window, pane)
		window:perform_action(
			wezterm.action.InputSelector({
				action = wezterm.action_callback(function(window2, pane2, id)
					local project = get_project_by_id(id)
					if project ~= nil then
						perform_open_tab(window2, pane2, project.name, {
							cwd = project.path,
							args = utils.get_shell(),
						})
					end
				end),
				title = "Select a Project",
				choices = choices,
			}),
			pane
		)
	end)
end
-- config_builder voi puuttua vanhemmista versioista, tämä on turvallinen tapa:
local config = (wezterm.config_builder and wezterm.config_builder()) or {}

-- Varmista että keys-taulu on olemassa ENNEN pluginia
config.keys = config.keys or {}

config.window_close_confirmation = "NeverPrompt"
config.default_prog = utils.get_shell()
config.check_for_updates = false
config.enable_tab_bar = true
config.color_scheme = "Brogrammer"
config.colors = { background = "black" }

-- ALT keybindings (korjattu)
for _, v in ipairs({
	{ "Enter", act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ "n", act.CloseCurrentPane({ confirm = true }) },
	{ "LeftArrow", act.ActivatePaneDirection("Left") },
	{ "RightArrow", act.ActivatePaneDirection("Right") },
	{ "UpArrow", act.ActivatePaneDirection("Up") },
	{ "DownArrow", act.ActivatePaneDirection("Down") },
	{ "t", act.SpawnTab("CurrentPaneDomain") },
	{ "q", act.CloseCurrentTab({ confirm = true }) },
	{ "c", act.CopyTo("ClipboardAndPrimarySelection") },
	{ "v", act.PasteFrom("Clipboard") },
	{ "+", act.IncreaseFontSize },
	{ "-", act.DecreaseFontSize },
	{ "0", act.ResetFontSize },

	{ "h", act.ActivateTabRelative(-1) },
	{ "l", act.ActivateTabRelative(1) },
	{ "p", select_project() }, -- ALT+p (project)
	{ "f", open_fzf_action() }, -- ALT+f
	{ "d", open_fzf_directory() }, -- ALT+d
	{ "i", act.ShowDebugOverlay }, -- ALT+i
}) do
	table.insert(config.keys, { mods = "ALT", key = v[1], action = v[2] })
end

table.insert(config.keys, {
	mods = "ALT|SHIFT",
	key = "Enter",
	action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
})

return config
