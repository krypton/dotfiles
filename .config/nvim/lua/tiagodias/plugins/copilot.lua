local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
}

M.config = function()
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
		copilot_node_command = vim.fn.expand("$HOME") .. "/.asdf/installs/nodejs/23.11.0/bin/node", -- Node.js version must be > 20
	})
end

return M
