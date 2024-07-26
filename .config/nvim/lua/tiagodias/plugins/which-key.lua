return {
	{ "echasnovski/mini.nvim", version = false },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			win = {
				border = "rounded", -- none, single, double, shadow
			},
		},
	},
}
