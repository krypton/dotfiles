return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "moon",
			transparent = true,
			styles = {
				floats = "transparent",
			},
			on_colors = function(colors)
				local util = require("tokyonight.util")
				colors.fg_gutter = util.lighten(colors.fg_gutter, 0.8)
			end,
		})
		vim.cmd.colorscheme("tokyonight-moon")
	end,
}
