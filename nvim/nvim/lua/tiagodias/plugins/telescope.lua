return {
	"nvim-telescope/telescope.nvim",
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

		telescope.setup({
			defaults = {
				file_ignore_patterns = { "%.git/" },
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
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
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy [f]ind [f]iles in cwd" })
		keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Fuzzy [f]ind [o] files" })
		keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "[F]ind [s]tring in cwd" })
		keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "[F]ind string under [c]ursor in cwd" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [b]uffers" })
		keymap.set(
			"n",
			"<leader>/",
			builtin.current_buffer_fuzzy_find,
			{ desc = "[/] Fuzzily search in current buffer" }
		)
		keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind [G]it Files" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
		keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "[F]ind [T]reesitter" })
	end,
}
