return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				["go"] = { "goimports", "gofumpt" },
				-- ruby = { "rubocop" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.DEBUG,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- Directly change the values on the built-in configuration
		-- require("conform.formatters.rubocop").env = {
		-- 	BUNDLE_GEMFILE = "/Users/tiagodias/work/.ruby-lsp/Gemfile",
		-- }
		-- require("conform.formatters.rubocop").command = "/Users/tiagodias/.local/share/nvim/mason/bin/rubocop"
	end,
}
