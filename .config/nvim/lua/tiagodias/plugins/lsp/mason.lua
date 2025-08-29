return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- I want to enable servers myself in lsp.lua
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

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"eslint_d", -- js linter
				"staticcheck", -- go linter https://staticcheck.dev/ integrates with gopls
				"delve", -- go debugger https://github.com/go-delve/delve
				"goimports", -- go auto import or remove import statements https://pkg.go.dev/golang.org/x/tools/cmd/goimports
				"gofumpt", -- go strictier formatter than gofmt https://github.com/mvdan/gofumpt
			},
		})
	end,
}
