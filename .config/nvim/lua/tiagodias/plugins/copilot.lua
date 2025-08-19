---@diagnostic disable: undefined-global
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
					local handle = io.popen("asdf current nodejs 2>/dev/null")
					local result = handle and handle:read("*a") or ""
					if handle then handle:close() end
					local version = result:match("(%d+%.%d+%.%d+)")
					if version then
						local asdf_node = vim.fn.expand("$HOME") .. "/.asdf/installs/nodejs/" .. version .. "/bin/node"
						if vim.loop.fs_stat(asdf_node) then
							return asdf_node
						end
					end
					return "node"
				end)(),
			})
		end,
	},
	{
		"yetone/avante.nvim",
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		-- ⚠️ must add this setting! ! !
		build = "make",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- add any opts here
			-- for example
			provider = "copilot",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		'NickvanDyke/opencode.nvim',
		dependencies = {
			-- Recommended for a better input and embedded terminal experience.
			-- To bypass: use your own `toggle` (if any), and override `opts.on_send` and `opts.on_opencode_not_found`.
			-- { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
			{ "cbochs/grapple.nvim" },
		},
		opts = {
			-- Your configuration, if any
		},
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
