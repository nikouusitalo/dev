local wez = require("wezterm")
local config = wez.config_builder()
config.enable_wayland = true
config.enable_tab_bar = false
config.color_scheme = "Brogrammer"
config.colors = {

	background = "black",
}

local keybinds = require("modules.keybinds")
config.keys = keybinds.keys
return config
