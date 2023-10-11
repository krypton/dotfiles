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
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local navic = require("nvim-navic")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

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
					vim.lsp.diagnostic.on_publish_diagnostics(
						nil,
						vim.tbl_extend("keep", params, { diagnostics = result.items }),
						{ client_id = client.id }
					)
				end)
			end

			diagnostic_handler() -- to request diagnostics on buffer when first attaching

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

		vim.diagnostic.config({
			virtual_text = false,
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

		-- configure ruby_ls as a ruby lsp server
		lspconfig["ruby_ls"].setup({
			capabilities = capabilities,
			on_attach = function(client, buffer)
				setup_diagnostics(client, buffer)
				on_attach(client, buffer)
			end,
			cmd_env = { BUNDLE_GEMFILE = "/Users/tiagodias/work/.ruby-lsp/Gemfile" },
			cmd = { "ruby-lsp" },
			init_options = {
				formatter = "none",
			},
		})
	end,
}
