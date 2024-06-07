return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			---@diagnostic disable-next-line: missing-fields
			treesitter.setup({
				auto_install = true,
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				-- ensure these language parsers are installed
				ensure_installed = {
					"markdown",
					"markdown_inline",
					"json",
					"javascript",
					"yaml",
					"html",
					"css",
					"bash",
					"lua",
					"vim",
					"vimdoc",
					"gitignore",
					"ruby",
					"go",
					"gomod",
					"gowork",
					"gosum",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}
