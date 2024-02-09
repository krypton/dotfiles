return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			style = "moon",
		})

		vim.cmd.colorscheme("tokyonight-moon")
		local highlights = {
			"Normal",
			"NormalFloat",
			"LineNr",
			"Folded",
			"NonText",
			"SpecialKey",
			"VertSplit",
			"SignColumn",
			"EndOfBuffer",
			"TablineFill", -- this is specific to how I like my tabline to look like
		}
		for _, name in pairs(highlights) do
			vim.cmd.highlight(name .. " guibg=none ctermbg=none")
		end
	end,
}

-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("gruvbox").setup()
-- 		vim.o.background = "dark" -- or "light" for light mode
-- 		vim.cmd([[colorscheme gruvbox]])
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 	end,
-- 	opts = {},
-- }

-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		local catppuccin = require("catppuccin")
--
-- 		catppuccin.setup({
-- 			flavour = "mocha", -- latte, frappe, macchiato, mocha
-- 			custom_highlights = function(colors)
-- 				return {
-- 					VertSplit = { fg = colors.surface0 },
-- 				}
-- 			end,
-- 		})
--
-- 		-- setup must be called before loading
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }
