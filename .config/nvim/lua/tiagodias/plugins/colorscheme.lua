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
		})
		vim.cmd.colorscheme("tokyonight-moon")
	end,
}
