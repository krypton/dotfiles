---@diagnostic disable: undefined-global
local M = {
	"echasnovski/mini.nvim",
	version = false,
}

M.config = function()
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
	require("mini.indentscope").setup({
		draw = {
			animation = require("mini.indentscope").gen_animation.none(),
		},
	})

	-- Extend and create a/i textobjects
	require('mini.ai').setup()

	-- File system navigation/manipulation
	require('mini.files').setup()
end

return M
