return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})

			-- Overrides the default get_option to use the ts_context_commentstring plugin
			local get_option = vim.filetype.get_option
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end

			-- Setup folding
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			-- Adds a higher foldlevel to start all files with folds open
			vim.wo.foldlevel = 100

			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			---@diagnostic disable-next-line: missing-fields
			treesitter.setup({
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
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
						init_selection = "<space><space>",
						node_incremental = "<space><space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}
