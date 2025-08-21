---@diagnostic disable: undefined-global

vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = "rounded" })

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

vim.lsp.log.set_level(vim.log.levels.DEBUG)
vim.lsp.enable({ 'ruby_lsp', 'lua_ls', 'ts_ls', 'gopls', 'taplo', 'html', 'cssls', 'marksman' })
