local function map(mode, lhs, rhs, opts)
	-- set default value if not specify
	if opts.noremap == nil then
		opts.noremap = true
	end
	if opts.silent == nil then
		opts.silent = true
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- better up/down
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map("n", "<C-u>", "<C-u>zz", {})
map("n", "<C-d>", "<C-d>zz", {})
map("n", "<C-b>", "<C-b>zz", {})
map("n", "<C-f>", "<C-f>zz", {})

-- leader movements
map("n", "<Leader>s", ":source %<CR>", {})
map("n", "<Leader>v", ":cd ~/.config/nvim/<CR>:Telescope find_files<CR>", {})
map("n", "<Leader>m", ":make<CR>", {})
map("n", "<Leader>pv", ":Ex<CR>", {})

-- quickfix
map("n", "<Leader>cn", ":cnext<CR>", {})
map("n", "<Leader>cp", ":cprev<CR>", {})
map("n", "<Leader>cc", ":cclose<CR>", {})
map("n", "<Leader>co", ":copen<CR>", {})

-- system clipboard
map({ "n", "v" }, "<Leader>y", '"+y', {})
map({ "n" }, "<Leader>Y", '"+y$', {})

map({ "n", "v" }, "<Leader>p", '"+p', {})
map({ "n", "v" }, "<Leader>P", '"+P', {})

-- window movements
map("n", "<C-k>", "<C-w>k", {})
map("n", "<C-j>", "<C-w>j", {})
map("n", "<C-h>", "<C-w>h", {})
map("n", "<C-l>", "<C-w>l", {})
map("n", "<C-c>", "<C-w>c", {}) -- closes tab
map("n", "<C-b>", "<C-w>s", {}) -- splits horizontally
map("n", "<C-s>", "<C-w>v", {}) -- splits vertically

map("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/tmux-sessionizer<CR>", {})
map("n", "<Leader>zz", "<cmd>ZenMode<CR>", {})
