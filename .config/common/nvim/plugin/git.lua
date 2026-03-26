-- gitsigns: load when opening a file
vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

		vim.schedule(function()
			require("gitsigns").setup({
				current_line_blame = true,
			})
		end)
	end,
})

-- neogit + diffview: load after startup
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/nvim-lua/plenary.nvim",
			"https://github.com/sindrets/diffview.nvim",
			"https://github.com/NeogitOrg/neogit",
		})

		vim.schedule(function()
			require("neogit").setup({})
			vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
		end)
	end,
})
