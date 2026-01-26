local wezterm = require("wezterm")
local projects = require("projects")
local utils = require("lua.utils")
local act = wezterm.action

local function get_fzf_command()
	if utils.is_windows() then
		return "fzf | ForEach-Object { nvim $_ }"
	end
	return 'nvim "$(fzf)"'
end

local function get_fzf_open_dir_command()
	if utils.is_windows() then
		return "not implemented yet, sorry"
	end
	return 'cd "$(find . -type d | fzf)"'
end

local function perform_open_tab(window, pane, title, opts)
	local action = wezterm.action.SpawnCommandInNewTab(opts)
	window:perform_action(action, pane)

	wezterm.time.call_after(0.2, function()
		local tab = window:active_tab()
		if tab then
			tab:set_title(title)
		end
	end)
end

local function open_fzf_action()
	local commands = get_fzf_command()

	return wezterm.action_callback(function(window, pane)
		window:perform_action(wezterm.action.SendString(commands .. "\n"), pane)
	end)
end

local function open_fzf_directory()
	local commands = get_fzf_open_dir_command()

	return wezterm.action_callback(function(window, pane)
		window:perform_action(wezterm.action.SendString(commands .. "\n"), pane)
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
					wezterm.log_info("select_project")
					wezterm.log_info(project)
					if project ~= nil then
						perform_open_tab(window2, pane2, project.name, { cwd = project.path })
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

config.check_for_updates = false
config.enable_tab_bar = true
config.color_scheme = "Brogrammer"
config.colors = { background = "black" }

-- CTRL+SHIFT keybindings
for _, v in ipairs({
	{ "s", "CTRL|SHIFT", wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ "t", "CTRL|SHIFT", wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ "w", "CTRL|SHIFT", wezterm.action.CloseCurrentTab({ confirm = true }) },
	{ "h", "CTRL|SHIFT", wezterm.action.ActivateTabRelative(-1) },
	{ "l", "CTRL|SHIFT", wezterm.action.ActivateTabRelative(1) },
	{ "N", "CTRL|SHIFT", select_project() },
	{ "F", "CTRL|SHIFT", open_fzf_action() },
	{ "D", "CTRL|SHIFT", open_fzf_directory() },
	{ "I", "CTRL|SHIFT", wezterm.action.ShowDebugOverlay },
}) do
	table.insert(config.keys, { key = v[1], mods = v[2], action = v[3] })
end

table.insert(config.keys, {
	mods = "ALT|SHIFT",
	key = "Enter",
	action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
})

return config
