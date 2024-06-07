local wezterm = require("wezterm")
local config = {
	-- https://wezfurlong.org/wezterm/config/lua/config/term.html
	font = wezterm.font("JetBrainsMonoNL Nerd Font Propo"),
	font_size = 13.0,
	color_scheme = "tokyonight_moon",
	window_background_opacity = 0.95,
	text_background_opacity = 0.95,
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	window_close_confirmation = "NeverPrompt",
}

return config
