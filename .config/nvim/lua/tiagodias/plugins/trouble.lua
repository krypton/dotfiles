---@diagnostic disable: undefined-global
local M = {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.config = function()
	local trouble = require("trouble")

	trouble.setup({
		win_config = { border = "rounded" },
	})
	-- set keymaps
	vim.keymap.set("n", "<leader>tt", function()
		trouble.toggle()
	end, { desc = "Toggle [x] trouble" })

	vim.keymap.set("n", "[d", function()
		trouble.next({ skip_groups = true, jump = true })
	end, { desc = "Go to next diagnostic" })

	vim.keymap.set("n", "]d", function()
		trouble.previous({ skip_groups = true, jump = true })
	end, { desc = "Go to previous diagnostic" })
end

return M
