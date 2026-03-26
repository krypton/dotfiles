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
		(vim.hl or vim.highlight).on_yank({ timeout = 200, visual = true })
	end,
})

-- Disable auto comment on new lines
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = { c = false, r = false, o = false }
	end,
})

-- Use Enter to toggle folds except in quickfix buffers
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "quickfix" then
			vim.keymap.set("n", "<CR>", function()
				local line = vim.fn.line(".")
				local foldlevel = vim.fn.foldlevel(line)
				if foldlevel == 0 then
					vim.notify("No fold found", vim.log.levels.INFO)
				else
					vim.cmd("normal! za")
				end
			end, { buffer = true, desc = "Toggle fold" })
		end
	end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	callback = function(_)
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- Restore cursor to last position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})
