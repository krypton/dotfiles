return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup()
		-- set keymaps
		vim.keymap.set("n", "<leader>tt", function()
			require("trouble").toggle()
		end, { desc = "Toggle [x] trouble" })

		vim.keymap.set("n", "[d", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end, { desc = "Go to next diagnostic" })

		vim.keymap.set("n", "]d", function()
			require("trouble").previous({ skip_groups = true, jump = true })
		end, { desc = "Go to previous diagnostic" })
		--
	end,
}
