local wezterm = require("wezterm")
local config = {
	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" }),
	font_size = 12.0,
	color_scheme = "Tokyo Night Moon",
	window_background_opacity = 0.95,
	text_background_opacity = 0.95,
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
}

return config
