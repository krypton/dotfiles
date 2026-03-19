vim.lsp.log.set_level(vim.log.levels.DEBUG)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})
vim.lsp.enable({ 'ruby_lsp', 'lua_ls', 'ts_ls', 'gopls', 'taplo', 'html', 'cssls', 'marksman' })
