vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

fzf.setup({
	"ivy",

	-- Sync fzf's internal TUI colors to the colorscheme. The FzfLua* Neovim
	-- highlight groups are set automatically by tokyonight.
	fzf_colors = true,

	winopts = {
		height = 0.4,
		width  = 1,
		row    = 1,
		col    = 0,
	},

	defaults = {
		file_icons = "mini",
	},

	files = {
		hidden = true,
	},

	grep = {
		hidden = true,
	},
})

vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [f]iles in cwd" })
vim.keymap.set("n", "<leader>ss", fzf.live_grep, { desc = "[S]earch [s]tring in cwd" })
vim.keymap.set("n", "<leader>sc", fzf.grep_cword, { desc = "[S]earch string under [c]ursor in cwd" })
vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "[S]earch existing [b]uffers" })
vim.keymap.set("n", "<leader>sg", fzf.git_files, { desc = "[S]earch [g]it files" })
vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "[S]earch [h]elp" })
vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [r]esume" })
