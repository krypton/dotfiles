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
		(vim.hl or vim.highlight).on_yank({ timeout = 200, visual = true })
	end,
})

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = { c = false, r = false, o = false }
	end,
})

-- Use Enter to fold except on quickfix
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(args)
		-- Check if current buffer is NOT a quickfix
		if vim.bo[args.buf].buftype ~= 'quickfix' then
			vim.keymap.set("n", "<CR>", function()
				-- Get the current line number
				local line = vim.fn.line(".")
				-- Get the fold level of the current line
				local foldlevel = vim.fn.foldlevel(line)
				if foldlevel == 0 then
					vim.notify("No fold found", vim.log.levels.INFO)
				else
					vim.cmd("normal! za")
				end
			end, { buffer = true, desc = "[P]Toggle fold" })
		end
	end,
})

-- Activates trailing whitespace on buffer save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	callback = function(_)
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
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

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup("binhuman-lsp-attach", {}),
	callback = function(args)
		local bufnr = args.buf

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" })
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, { buffer = bufnr, desc = "Show documentation for what is under cursor" })
		-- Add diagnostics to quickfix keybinding
		vim.keymap.set('n', '<leader>qd', function()
			vim.diagnostic.setqflist({ open = true })
		end, { buffer = bufnr, desc = 'Open diagnostics in quickfix' })

		-- Alternative: only errors
		vim.keymap.set('n', '<leader>qe', function()
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR, open = true })
		end, { buffer = bufnr, desc = 'Open errors in quickfix' })

		-- Alternative: current buffer only
		vim.keymap.set('n', '<leader>qD', function()
			vim.diagnostic.setloclist({ open = true })
		end, { buffer = bufnr, desc = 'Open buffer diagnostics in location list' })

		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format({ bufnr = bufnr })
		end, { desc = "Format current buffer with LSP" })
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
	desc = "Highlight references under cursor",
	callback = function()
		-- Only run if the cursor is not in insert mode
		if vim.fn.mode() ~= "i" then
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supports_highlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supports_highlight = true
					break -- Found a supporting client, no need to check others
				end
			end

			-- 3. Proceed only if an LSP is active AND supports the feature
			if supports_highlight then
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end
		end
	end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
	group = "LspReferenceHighlight",
	desc = "Clear highlights when entering insert mode",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})
