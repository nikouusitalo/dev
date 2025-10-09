local wez = require("wezterm")
local config = wez.config_builder()

config.enable_tab_bar = false
config.color_scheme = "Brogrammer"
config.colors = { background = "black" }

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

local keybinds = require("modules.keybinds")
config.keys = keybinds.keys
local bar = require("modules.bar")

return config
