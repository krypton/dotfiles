vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

		vim.schedule(function()
			require("conform").setup({
				formatters_by_ft = {
					["javascript"]      = { "prettier" },
					["javascriptreact"] = { "prettier" },
					["typescript"]      = { "prettier" },
					["typescriptreact"] = { "prettier" },
					["vue"]             = { "prettier" },
					["css"]             = { "prettier" },
					["scss"]            = { "prettier" },
					["less"]            = { "prettier" },
					["html"]            = { "prettier" },
					["json"]            = { "prettier" },
					["jsonc"]           = { "prettier" },
					["yaml"]            = { "prettier" },
					["markdown"]        = { "prettier" },
					["markdown.mdx"]    = { "prettier" },
					["graphql"]         = { "prettier" },
					["handlebars"]      = { "prettier" },
					["lua"]             = { "stylua" },
					["go"]              = { "goimports", "gofumpt" },
				},
				format_on_save = {
					lsp_format = "prefer",
					async = false,
					timeout_ms = 1000,
				},
			})
		end)
	end,
})
