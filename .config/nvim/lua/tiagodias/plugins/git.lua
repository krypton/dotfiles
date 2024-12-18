return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"ibhagwan/fzf-lua", -- optional
		},
		config = function()
			require("neogit").setup({})

			-- Keybindings
			vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>")
		end,
	},
}
