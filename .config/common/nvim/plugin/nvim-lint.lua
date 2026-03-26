vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

		vim.schedule(function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript      = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescript      = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				go              = { "staticcheck" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("binhuman-lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end)
	end,
})
