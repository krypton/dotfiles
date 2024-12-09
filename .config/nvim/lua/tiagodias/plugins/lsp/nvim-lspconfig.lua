return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },

		-- Additional lua configuration, makes nvim stuff amazing!
		"folke/neodev.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local ui_windows = require("lspconfig.ui.windows")

		ui_windows.default_options.border = "rounded"

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = "rounded" })

		local on_attach = function(client, bufnr)
			vim.keymap.set("n", "gR", ":FzfLua lsp_references<CR>", { buffer = bufnr, desc = "Show LSP references" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
			vim.keymap.set("n", "gd", ":FzfLua lsp_definitions<CR>", { buffer = bufnr, desc = "Show LSP definitions" })
			vim.keymap.set(
				"n",
				"gs",
				":FzfLua lsp_document_symbols<CR>",
				{ buffer = bufnr, desc = "Show LSP document symbols" }
			)
			vim.keymap.set(
				"n",
				"gi",
				":FzfLua lsp_implementations<CR>",
				{ buffer = bufnr, desc = "Show LSP implementations" }
			)
			vim.keymap.set(
				"n",
				"gt",
				":FzfLua lsp_typedefs<CR>",
				{ buffer = bufnr, desc = "Show LSP type definitions" }
			)
			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ buffer = bufnr, desc = "See available code actions" }
			)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" })
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover({ border = "rounded" })
			end, { buffer = bufnr, desc = "Show documentation for what is under cursor" })
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { buffer = bufnr, desc = "Restart LSP" })

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })

			-- Get nvim-navic (a dependecy of barbecue) working with multiple tabs
			if client.server_capabilities.documentSymbolProvider then
				require("nvim-navic").attach(client, bufnr)
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

		local function add_ruby_deps_command(client, bufnr)
			vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
				local params = vim.lsp.util.make_text_document_params()
				local showAll = opts.args == "all"

				client.request("rubyLsp/workspace/dependencies", params, function(error, result)
					if error then
						print("Error showing deps: " .. error)
						return
					end

					local qf_list = {}
					for _, item in ipairs(result) do
						if showAll or item.dependency then
							table.insert(qf_list, {
								text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
								filename = item.path,
							})
						end
					end

					vim.fn.setqflist(qf_list)
					vim.cmd("copen")
				end, bufnr)
			end, {
				nargs = "?",
				complete = function()
					return { "all" }
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
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

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
		lspconfig["ts_ls"].setup({
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
				add_ruby_deps_command(client, buffer)
				on_attach(client, buffer)
			end,
			mason = false,
			cmd = { "ruby-lsp" },
			init_options = {
				enabledFeatures = {
					"codeActions",
					"codeLens",
					"completion",
					"definition",
					"diagnostics",
					"documentHighlights",
					"documentLink",
					"documentSymbols",
					"foldingRanges",
					"formatting",
					"hover",
					"inlayHint",
					"onTypeFormatting",
					"selectionRanges",
					"semanticHighlighting",
					"signatureHelp",
					"typeHierarchy",
					"workspaceSymbol",
				},
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
