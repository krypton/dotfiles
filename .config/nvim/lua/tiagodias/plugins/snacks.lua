---@diagnostic disable: undefined-global
local M = {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		picker = {
			enabled = true,
			layout = "vertical",
		},
		input = {
			enabled = true,
		},
	},
	keys = {
		{ "<leader>sf", function() Snacks.picker.files({ hidden = true }) end,     desc = "[S]earch [f]iles in cwd" },
		{ "<leader>ss", function() Snacks.picker.grep({ hidden = true }) end,      desc = "[S]earch [s]tring in cwd" },
		{ "<leader>sc", function() Snacks.picker.grep_word({ hidden = true }) end, desc = "[S]earch string under [c]ursor in cwd" },
		{ "<leader>sb", function() Snacks.picker.buffers() end,                    desc = "[S]earch existing [b]uffers" },
		{ "<leader>sg", function() Snacks.picker.git_files() end,                  desc = "[S]earch [g]it files" },
		{ "<leader>sh", function() Snacks.picker.help() end,                       desc = "[S]earch [h]elp" },
		{ "<leader>sr", function() Snacks.picker.resume() end,                     desc = "[S]earch [r]esume" },
		-- LSP
		{ "gd",         function() Snacks.picker.lsp_definitions() end,            desc = "Goto Definition" },
		{ "gr",         function() Snacks.picker.lsp_references() end,             nowait = true,                                 desc = "References" },
		{ "gi",         function() Snacks.picker.lsp_implementations() end,        desc = "Goto Implementation" },
		{ "gt",         function() Snacks.picker.lsp_type_definitions() end,       desc = "Goto T[y]pe Definition" },
		{ "gs",         function() Snacks.picker.lsp_symbols() end,                desc = "LSP Symbols" },
	}
}

return M
