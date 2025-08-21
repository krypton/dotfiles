return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "saghen/blink.cmp" },
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local ui_windows = require("lspconfig.ui.windows")

		ui_windows.default_options.border = "rounded"

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})
	end,
}
