---@diagnostic disable: undefined-global
-- only highlight when searching
vim.api.nvim_create_autocmd("CmdlineEnter", {
	callback = function()
		local cmd = vim.v.event.cmdtype
		if cmd == "/" or cmd == "?" then
			vim.opt.hlsearch = true
		end
	end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		local cmd = vim.v.event.cmdtype
		if cmd == "/" or cmd == "?" then
			vim.opt.hlsearch = false
		end
	end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying text)",
	group = vim.api.nvim_create_augroup("binhuman-highlight-yank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank({ timeout = 200 })
	end,
})

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = { c = false, r = false, o = false }
	end,
})

-- Activates trailing whitespace on buffer save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function(_)
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Set the border of mini.files window to rounded
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesWindowOpen",
	callback = function(args)
		local win_id = args.data.win_id
		local config = vim.api.nvim_win_get_config(win_id)

		config.border = "rounded"
		vim.api.nvim_win_set_config(win_id, config)
	end,
})

local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		-- Make new window and set it as target
		local cur_target = MiniFiles.get_explorer_state().target_window
		local new_target = vim.api.nvim_win_call(cur_target, function()
			vim.cmd(direction .. ' split')
			return vim.api.nvim_get_current_win()
		end)

		MiniFiles.set_target_window(new_target)

		-- This intentionally doesn't act on file under cursor in favor of
		-- explicit "go in" action (`l` / `L`). To immediately open file,
		-- add appropriate `MiniFiles.go_in()` call instead of this comment.
		MiniFiles.go_in({
			close_on_file = true,
		})
	end

	-- Adding `desc` will result into `show_help` entries
	local desc = 'Split ' .. direction
	vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd('User', {
	pattern = 'MiniFilesBufferCreate',
	callback = function(args)
		local buf_id = args.data.buf_id

		map_split(buf_id, '<C-s>', 'belowright horizontal')
		map_split(buf_id, '<C-v>', 'belowright vertical')
	end,
})
