vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

require("mini.statusline").setup({
	use_icons = true,
})

require("mini.notify").setup({
	window = {
		winblend = 0,
	},
})
vim.cmd("au ColorScheme * highlight MiniNotifyNormal guibg=NONE")
vim.cmd("au ColorScheme * highlight MiniNotifyTitle guibg=NONE")
vim.cmd("au ColorScheme * highlight MiniNotifyBorder guibg=NONE")
vim.notify = require("mini.notify").make_notify()

-- Draws a line between the start and end of textobjects
require("mini.indentscope").setup({
	draw = {
		animation = require("mini.indentscope").gen_animation.none(),
	},
})

-- Extend and create a/i textobjects
require("mini.ai").setup()

-- File system navigation/manipulation
require("mini.files").setup()

-- Use icons for diagnostics, git, etc
require("mini.icons").setup()

-- Keymap to open file explorer at current file
vim.keymap.set("n", "<leader>pv", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open file explorer" })

-- MiniFiles split keymaps
local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		local cur_target = MiniFiles.get_explorer_state().target_window
		local new_target = vim.api.nvim_win_call(cur_target, function()
			vim.cmd(direction .. " split")
			return vim.api.nvim_get_current_win()
		end)
		MiniFiles.set_target_window(new_target)
		MiniFiles.go_in({ close_on_file = true })
	end
	vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		map_split(buf_id, "<C-s>", "belowright horizontal")
		map_split(buf_id, "<C-v>", "belowright vertical")
	end,
})
