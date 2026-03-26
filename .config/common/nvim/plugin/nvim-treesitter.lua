vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/nvim-treesitter/nvim-treesitter-context",
			"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
			"https://github.com/nvim-treesitter/nvim-treesitter",
		})

		-- vim.schedule defers require() calls to after vim.pack.add() has fully
		-- sourced the plugins into the runtime path
		vim.schedule(function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})

			-- Override get_option to use ts_context_commentstring for commentstring
			local get_option = vim.filetype.get_option
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
					and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end

			-- Setup treesitter folding
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo.foldlevel = 100

			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.config").setup({
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
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
		end)
	end,
})
