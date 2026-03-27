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
				if option == "commentstring" then
					local ok, cs = pcall(require("ts_context_commentstring.internal").calculate_commentstring)
					if ok and cs then
						return cs
					end
				end
				return get_option(filetype, option)
			end

			-- nvim-treesitter rewrite: setup() only accepts install_dir
			require("nvim-treesitter").setup()

			-- Install parsers for desired languages
			require("nvim-treesitter").install({
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
			})

			-- Enable treesitter features per buffer via FileType autocmd.
			-- Highlighting is now built-in (vim.treesitter.start), indent and
			-- folding are set per-buffer when a parser is available.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf = args.buf

					-- Skip large files
					local ok_stat, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok_stat and stats and stats.size > 100 * 1024 then
						return
					end

					local ok = pcall(vim.treesitter.start, buf)
					if not ok then
						return
					end

					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

					-- foldmethod/foldexpr/foldlevel are window-local; [0][0] scopes
					-- them to the current window+buffer pair (Neovim 0.10+)
					vim.wo[0][0].foldmethod = "expr"
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldlevel = 100
				end,
			})

			-- Re-trigger FileType for the buffer that caused this lazy-load so
			-- the autocmd above fires for it too (its FileType event already ran
			-- before the autocmd was registered)
			vim.api.nvim_exec_autocmds("FileType", { buffer = vim.api.nvim_get_current_buf() })
		end)
	end,
})
