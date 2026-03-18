local utils = require("lua.utils")
local home_dir = utils.get_home_dir()

local projects = {
	{
		id = "hyprland",
		name = "Hyprland",
		path = home_dir .. "/.config/hypr/",
	},
	{
		id = "dev",
		name = "Dev",
		path = home_dir .. "/code/",
	},
}
return projects
