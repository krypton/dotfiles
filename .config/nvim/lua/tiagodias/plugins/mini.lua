return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.statusline").setup({
			use_icons = true,
		})

		require("mini.notify").setup({
			window = {
				config = {
					border = "rounded",
				},
				winblend = 0,
			},
		})
		vim.cmd("au ColorScheme * highlight MiniNotifyNormal guibg=NONE")
		vim.cmd("au ColorScheme * highlight MiniNotifyTitle guibg=NONE")
		vim.cmd("au ColorScheme * highlight MiniNotifyBorder guibg=NONE")
		vim.notify = require("mini.notify").make_notify()

		-- Draws a line between the start and end of textobjects
		require("mini.indentscope").setup()
	end,
}
