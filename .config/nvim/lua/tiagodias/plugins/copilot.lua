local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
}

M.config = function()
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})
end

return M
