vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.pack.add({ "https://github.com/folke/which-key.nvim" })

		vim.schedule(function()
			require("which-key").setup({})
		end)
	end,
})
