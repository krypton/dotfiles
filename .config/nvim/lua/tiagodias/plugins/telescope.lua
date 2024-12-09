return {
	"nvim-telescope/telescope.nvim",
	enabled = false,
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local telescopeConfig = require("telescope.config")

		-- Clone the default Telescope configuration
		local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

		-- I want to search in hidden/dot files.
		table.insert(vimgrep_arguments, "--hidden")
		-- I don't want to search in the `.git` directory.
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				vimgrep_arguments = vimgrep_arguments,
				file_ignore_patterns = { "%.git/" },
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
				preview = {
					treesiter = true,
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		vim.keymap.set(
			"n",
			"<leader>s/",
			builtin.current_buffer_fuzzy_find,
			{ desc = "[S]earch in current buffer [/]" }
		)
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [f]iles in cwd" })
		vim.keymap.set("n", "<leader>ss", builtin.live_grep, { desc = "[S]earch [s]tring in cwd" })
		vim.keymap.set("n", "<leader>sc", builtin.grep_string, { desc = "[S]earch string under [c]ursor in cwd" })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch existing [b]uffers" })
		vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "[S]earch [g]it files" })
		vim.keymap.set("n", "<leader>sh", function()
			builtin.help_tags({
				previewer = false,
				layout_strategy = "vertical",
				layout_config = {
					width = 0.5,
				},
			})
		end, { desc = "[S]earch [h]elp" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [d]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [r]esume" })
	end,
}
