return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		-- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		"folke/neodev.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local navic = require("nvim-navic")

		require("lspconfig.ui.windows").default_options.border = "rounded"

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

		local on_attach = function(client, bufnr)
			vim.keymap.set(
				"n",
				"gS",
				":Telescope lsp_document_symbols<CR>",
				{ buffer = bufnr, desc = "Show document symbols" }
			)
			vim.keymap.set("n", "gR", ":Telescope lsp_references<CR>", { buffer = bufnr, desc = "Show LSP references" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
			vim.keymap.set(
				"n",
				"gd",
				":Telescope lsp_definitions<CR>",
				{ buffer = bufnr, desc = "Show LSP definitions" }
			)
			vim.keymap.set(
				"n",
				"gi",
				":Telescope lsp_implementations<CR>",
				{ buffer = bufnr, desc = "Show LSP implementations" }
			)
			vim.keymap.set(
				"n",
				"gt",
				":Telescope lsp_type_definitions<CR>",
				{ buffer = bufnr, desc = "Show LSP type definitions" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ buffer = bufnr, desc = "See available code actions" }
			)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" })
			vim.keymap.set(
				"n",
				"K",
				vim.lsp.buf.hover,
				{ buffer = bufnr, desc = "Show documentation for what is under cursor" }
			)
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { buffer = bufnr, desc = "Restart LSP" })

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })

			-- Get nvim-navic (a dependecy of barbecue) working with multiple tabs
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
		end

		-- textDocument/diagnostic support until 0.10.0 is released
		Lsptimers = {}
		local function setup_diagnostics(client, buffer)
			if require("vim.lsp.diagnostic")._enable then
				return
			end

			local diagnostic_handler = function()
				local params = vim.lsp.util.make_text_document_params(buffer)
				client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
					if err then
						local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
						vim.lsp.log.error(err_msg)
					end
					if not result then
						return
					end
					---@diagnostic disable-next-line: missing-parameter
					vim.lsp.diagnostic.on_publish_diagnostics(
						nil,
						vim.tbl_extend("keep", params, { diagnostics = result.items }),
						{ client_id = client.id }
					)
				end)
			end

			diagnostic_handler()

			vim.api.nvim_buf_attach(buffer, false, {
				on_lines = function()
					if Lsptimers[buffer] then
						vim.fn.timer_stop(Lsptimers[buffer])
					end
					Lsptimers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
				end,
				on_detach = function()
					if Lsptimers[buffer] then
						vim.fn.timer_stop(Lsptimers[buffer])
					end
				end,
			})
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- capabilities.textDocument.completion.completionItem.snippetSupport = true
		-- capabilities.textDocument.foldingRange = {
		-- dynamicRegistration = false,
		-- lineFoldingOnly = true,
		-- }

		-- This enables LSP diagnostics to be shown inline
		vim.diagnostic.config({
			virtual_text = true,
			float = { border = "rounded" },
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Neovim api and docs support for lua
		require("neodev").setup()

		vim.lsp.set_log_level("debug")

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure typescript server with plugin
		lspconfig["tsserver"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure lua server
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})

		-- configure ruby_lsp as a ruby lsp server
		lspconfig["ruby_lsp"].setup({
			capabilities = capabilities,
			on_attach = function(client, buffer)
				setup_diagnostics(client, buffer)
				on_attach(client, buffer)
			end,
			cmd_env = { BUNDLE_GEMFILE = "/Users/tiagodias/work/.ruby-lsp/Gemfile" },
			cmd = { "ruby-lsp" },
			init_options = {
				formatter = "rubocop",
			},
		})

		-- configure gopls server
		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				gopls = {
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		-- configure toml server with plugin
		lspconfig["taplo"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
