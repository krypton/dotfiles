vim.pack.add({ "https://github.com/aserowy/tmux.nvim" })

require("tmux").setup({
	-- Disable copy_sync, freezes neovim navigation between splits
	copy_sync = {
		enable = false,
	},
})
