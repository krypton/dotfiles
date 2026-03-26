vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	picker = {
		enabled = true,
		layout = "ivy_split",
	},
	input = {
		enabled = true,
	},
})

vim.keymap.set("n", "<leader>sf", function() Snacks.picker.files({ hidden = true }) end,     { desc = "[S]earch [f]iles in cwd" })
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.grep({ hidden = true }) end,      { desc = "[S]earch [s]tring in cwd" })
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.grep_word({ hidden = true }) end, { desc = "[S]earch string under [c]ursor in cwd" })
vim.keymap.set("n", "<leader>sb", function() Snacks.picker.buffers() end,                    { desc = "[S]earch existing [b]uffers" })
vim.keymap.set("n", "<leader>sg", function() Snacks.picker.git_files() end,                  { desc = "[S]earch [g]it files" })
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end,                       { desc = "[S]earch [h]elp" })
vim.keymap.set("n", "<leader>sr", function() Snacks.picker.resume() end,                     { desc = "[S]earch [r]esume" })
