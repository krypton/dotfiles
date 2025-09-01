local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		win = {
			border = "rounded", -- none, single, double, shadow
		},
	},
}

M.init = function()
	vim.o.timeout = true
	vim.o.timeoutlen = 500
end

return M
