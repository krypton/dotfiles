vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/williamboman/mason-lspconfig.nvim",
			"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
			"https://github.com/williamboman/mason.nvim",
			"https://github.com/neovim/nvim-lspconfig",
		})

		vim.schedule(function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			require("mason-lspconfig").setup({
				-- Servers are enabled manually in core/lsp.lua
				automatic_enable = false,
				ensure_installed = {
					"lua_ls",
					"cssls",
					"html",
					"ts_ls",
					"gopls",
					"taplo",
					"marksman",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier", -- formatter
					"stylua", -- lua formatter
					"eslint_d", -- js/ts linter
					"staticcheck", -- go linter
					"delve", -- go debugger
					"goimports", -- go auto imports
					"gofumpt", -- go strict formatter
				},
			})
		end)
	end,
})

-- LspAttach: keymaps and commands for LSP buffers
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("binhuman-lsp-attach", {}),
	callback = function(args)
		local bufnr = args.buf

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" })
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, { buffer = bufnr, desc = "Show documentation for what is under cursor" })

		vim.keymap.set("n", "<leader>qd", function()
			vim.diagnostic.setqflist({ open = true })
		end, { buffer = bufnr, desc = "Open diagnostics in quickfix" })

		vim.keymap.set("n", "<leader>qe", function()
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR, open = true })
		end, { buffer = bufnr, desc = "Open errors in quickfix" })

		vim.keymap.set("n", "<leader>qD", function()
			vim.diagnostic.setloclist({ open = true })
		end, { buffer = bufnr, desc = "Open buffer diagnostics in location list" })

		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format({ bufnr = bufnr })
		end, { desc = "Format current buffer with LSP" })
	end,
})

-- Highlight references under cursor
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("binhuman-lsp-highlight", { clear = true }),
	desc = "Highlight references under cursor",
	callback = function()
		if vim.fn.mode() ~= "i" then
			local buftype = vim.bo.buftype
			if buftype ~= "" and buftype ~= "acwrite" then return end

			local clients = vim.lsp.get_clients({ bufnr = 0 })
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					vim.lsp.buf.clear_references()
					vim.lsp.buf.document_highlight()
					return
				end
			end
		end
	end,
})

-- Clear highlights when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	group = "binhuman-lsp-highlight",
	desc = "Clear highlights when entering insert mode",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
