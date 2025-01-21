-- better up/down
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- window movements
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-c>", "<C-w>c") -- closes tab
vim.keymap.set("n", "<C-b>", "<C-w>s") -- splits horizontally
vim.keymap.set("n", "<C-s>", "<C-w>v") -- splits vertically

-- leader movements
vim.keymap.set("n", "<leader><leader>x", ":source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
vim.keymap.set("n", "<leader>pv", ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'") -- move line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'") -- move line up

-- quickfix
vim.keymap.set("n", "<leader>cn", ":cnext<CR>")
vim.keymap.set("n", "<leader>cp", ":cprev<CR>")
vim.keymap.set("n", "<leader>cc", ":cclose<CR>")
vim.keymap.set("n", "<leader>co", ":copen<CR>")

-- system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n" }, "<leader>Y", '"+y$')

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/tmux-sessionizer<CR>")

vim.keymap.set("n", "<Up>", "")
vim.keymap.set("n", "<Down>", "")
vim.keymap.set("n", "<Left>", "")
vim.keymap.set("n", "<Right>", "")
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
end, { desc = "[P]Toggle fold" })
