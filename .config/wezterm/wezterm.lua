local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 12.0
config.color_scheme = "Tokyo Night Moon"
config.window_background_opacity = 0.97
config.text_background_opacity = 0.97
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

-- Maximize window on startup
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
