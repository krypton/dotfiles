---@diagnostic disable: undefined-global
local M = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
}

M.config = function()
	require("tokyonight").setup({
		style = "moon",
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		on_colors = function(colors)
			local util = require("tokyonight.util")
			colors.fg_gutter = util.lighten(colors.fg_gutter, 0.8)
		end,
		on_highlights = function(highlights, colors)
			highlights["Folded"].bg = colors.bg_highlight
		end
	})
	vim.cmd.colorscheme("tokyonight-moon")
end

return M
