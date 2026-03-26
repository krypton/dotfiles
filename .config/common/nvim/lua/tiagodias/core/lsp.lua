vim.lsp.log.set_level(vim.log.levels.WARN)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
				},
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})
vim.lsp.enable({ 'ruby_lsp', 'lua_ls', 'ts_ls', 'gopls', 'taplo', 'html', 'cssls', 'marksman' })
