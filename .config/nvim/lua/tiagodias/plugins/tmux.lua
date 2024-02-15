-- This integrates with the same package used on TPM package manager on .tmux.conf
return {
	{
		"aserowy/tmux.nvim",
		config = function()
			local tmux = require("tmux")

			tmux.setup()
		end,
	},
	{
		"vimpostor/vim-tpipeline",
		config = function()
			-- Restore the previous statusline after quitting vim
			vim.g.tpipeline_restore = 1
			-- Clear duplicate statusline when there is split windows
			vim.g.tpipeline_clearstl = 1
		end,
	},
}
