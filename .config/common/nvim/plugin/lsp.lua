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
					"stylua",   -- lua formatter
					"eslint_d", -- js/ts linter
					"staticcheck", -- go linter
					"delve",    -- go debugger
					"goimports", -- go auto imports
					"gofumpt",  -- go strict formatter
					"copilot-language-server", -- GitHub Copilot LSP
				},
			})
		end)
	end,
})

-- LspAttach: keymaps, commands and per-buffer autocmds for LSP buffers
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("binhuman-lsp-attach", {}),
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

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

		-- Inlay hints (types, parameter names)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		-- Inline completions (e.g. Copilot LSP)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
			vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
			vim.keymap.set("i", "<C-F>", vim.lsp.inline_completion.get,
				{ buffer = bufnr, desc = "LSP: accept inline completion" })
			vim.keymap.set("i", "<C-G>", vim.lsp.inline_completion.select,
				{ buffer = bufnr, desc = "LSP: switch inline completion" })
		end

		-- Highlight references under cursor (scoped to this buffer/client)
		if client and client:supports_method("textDocument/documentHighlight") then
			local group = vim.api.nvim_create_augroup("binhuman-lsp-highlight-" .. bufnr, {})
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = group,
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
				group = group,
				buffer = bufnr,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})
