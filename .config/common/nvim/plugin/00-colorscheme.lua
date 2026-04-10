vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })

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

		-- mini.pick
		highlights["MiniPickBorder"]       = { fg = colors.blue,        bg = "NONE" }
		highlights["MiniPickBorderBusy"]   = { fg = colors.yellow,       bg = "NONE" }
		highlights["MiniPickBorderText"]   = { fg = colors.blue,         bg = "NONE", bold = true }
		highlights["MiniPickNormal"]       = { fg = colors.fg,           bg = "NONE" }
		highlights["MiniPickMatchCurrent"] = { fg = colors.fg,           bg = colors.bg_highlight }
		highlights["MiniPickMatchRanges"]  = { fg = colors.blue,         bold = true }
		highlights["MiniPickMatchMarked"]  = { fg = colors.orange,       italic = true }
		highlights["MiniPickPrompt"]       = { fg = colors.blue,         bg = "NONE", bold = true }
		highlights["MiniPickHeader"]       = { fg = colors.blue1,        bg = "NONE", bold = true }
	end,
})

vim.cmd.colorscheme("tokyonight-moon")
