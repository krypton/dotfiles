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
	{
		'NickvanDyke/opencode.nvim',
		dependencies = {
			{ "cbochs/grapple.nvim" },
		},
		opts = {},
		keys = {
			-- Recommended keymaps
			{ '<leader>oa', function() require('opencode').ask('@cursor: ') end,                          desc = 'Ask opencode',                 mode = 'n', },
			{ '<leader>oa', function() require('opencode').ask('@selection: ') end,                       desc = 'Ask opencode about selection', mode = 'v', },
			{ '<leader>ot', function() require('opencode').toggle() end,                                  desc = 'Toggle embedded opencode', },
			{ '<leader>on', function() require('opencode').command('session_new') end,                    desc = 'New session', },
			{ '<leader>oy', function() require('opencode').command('messages_copy') end,                  desc = 'Copy last message', },
			{ '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,          desc = 'Scroll messages up', },
			{ '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end,        desc = 'Scroll messages down', },
			{ '<leader>op', function() require('opencode').select_prompt() end,                           desc = 'Select prompt',                mode = { 'n', 'v', }, },
			-- Example: keymap for custom prompt
			{ '<leader>oe', function() require('opencode').prompt("Explain @cursor and its context") end, desc = "Explain code near cursor", },
		},
	}
}
