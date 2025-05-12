local wez = require "wezterm"
local config = wez.config_builder()


config.enable_tab_bar = false
config.color_scheme = 'Brogrammer'
config.colors = {

    background = 'black',


}
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.keys = {
    {
        key    = 'i',
        mods   = 'CTRL',
        action = wez.action.SpawnCommandInNewWindow {
            args = {
                "bash", -- käytettävä shell
                "-lc",  -- lataa käyttäjän shell-profiili (esim. $PATH yms)
                "/home/nikouu/test/test.sh; exec bash"
                -- skripti ajetaan ja lopuksi käynnistyy interaktiivinen bash,
                -- jotta ikkuna ei sulkeudu automaattisesti.
            },
            cwd = wez.home, -- (vapaaehtoinen) työskentelyhakemisto; esim. wez.home
        },
    },
}
return config
