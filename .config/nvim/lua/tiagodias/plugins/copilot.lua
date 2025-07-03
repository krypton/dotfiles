--- GitHub Copilot integration for Neovim
--- Provides AI-powered code completion and chat functionality
return {
	-- Main Copilot plugin for code suggestions
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				-- Use specific Node.js version from asdf if available, else fallback to system node
				copilot_node_command = (function()
					local asdf_node = vim.fn.expand("$HOME") .. "/.asdf/installs/nodejs/23.11.0/bin/node"
					if vim.loop.fs_stat(asdf_node) then
						return asdf_node
					else
						return "node"
					end
				end)(),
			})
		end,
	},
	-- Copilot Chat for interactive AI assistance
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },          -- Core Copilot functionality
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- Required for curl, log and async functions
		},
		build = "make tiktoken",                   -- Build tiktoken for MacOS/Linux
		opts = {
			-- Configuration options for CopilotChat
		},
	},
}
