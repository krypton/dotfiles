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

-- Fuzzy finder (bottom-anchored, approximates ivy_split layout)
require("mini.pick").setup({
	window = {
		config = function()
			local height = math.floor(0.4 * vim.o.lines)
			return {
				anchor = "SW",
				row = vim.o.lines - vim.o.cmdheight - 1,
				col = 0,
				width = vim.o.columns,
				height = height,
			}
		end,
	},
})
require("mini.extra").setup()

-- Choose handler for rg output (file:line:col:content)
local function grep_choose(item)
	if not item then return end
	local file, line, col = item:match("^([^:]+):(%d+):(%d+):")
	if file then
		vim.cmd.edit(file)
		vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 })
	end
end

-- Live grep with --hidden using set_picker_items_from_cli + querytick to avoid stale updates
local function grep_live_hidden()
	local base = { "rg", "--column", "--line-number", "--no-heading", "--color=never", "--hidden", "--glob", "!.git" }
	MiniPick.start({
		source = {
			name    = "Grep",
			items   = {},
			match   = function(_, _, query)
				local querytick = MiniPick.get_picker_state().querytick
				local query_str = table.concat(query)
				MiniPick.set_picker_match_inds({})
				if query_str == "" then return end
				local cmd = vim.list_extend(vim.deepcopy(base), { query_str })
				MiniPick.set_picker_items_from_cli(cmd, {
					set_items_opts = { do_match = false, querytick = querytick },
				})
			end,
			choose  = grep_choose,
		},
	})
end

vim.keymap.set("n", "<leader>sf", function()
	MiniPick.start({
		source = {
			name   = "Files",
			items  = vim.schedule_wrap(function()
				MiniPick.set_picker_items_from_cli({ "fd", "--type", "f", "--hidden", "--exclude", ".git" })
			end),
		},
	})
end, { desc = "[S]earch [f]iles in cwd" })
vim.keymap.set("n", "<leader>ss", grep_live_hidden,                                                    { desc = "[S]earch [s]tring in cwd" })
vim.keymap.set("n", "<leader>sc", function()
	local word = vim.fn.expand("<cword>")
	local cmd  = { "rg", "--column", "--line-number", "--no-heading", "--color=never", "--hidden", "--glob", "!.git", word }
	MiniPick.start({
		source = { name = "Grep: " .. word, items = vim.fn.systemlist(cmd), choose = grep_choose },
	})
end,                                                                                                   { desc = "[S]earch string under [c]ursor in cwd" })
vim.keymap.set("n", "<leader>sb", function() MiniPick.builtin.buffers() end,                          { desc = "[S]earch existing [b]uffers" })
vim.keymap.set("n", "<leader>sg", function() MiniExtra.pickers.git_files() end,                       { desc = "[S]earch [g]it files" })
vim.keymap.set("n", "<leader>sh", function() MiniPick.builtin.help() end,                             { desc = "[S]earch [h]elp" })
vim.keymap.set("n", "<leader>sr", function() MiniPick.builtin.resume() end,                           { desc = "[S]earch [r]esume" })
