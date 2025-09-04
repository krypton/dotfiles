vim.loader.enable() -- Enables the experimental Lua module loader

-- Leader key mapped to <space>
vim.g.mapleader          = " "
vim.g.maplocalleader     = " "

-- netrw global settings
vim.g.netrw_banner       = 0 -- gets rid of the annoying banner for netrw
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_altv         = 1 -- change from left splitting to right splitting
vim.g.netrw_liststyle    = 3 -- tree style view in netrw

-- Global options
vim.opt.backup           = false         -- Don't store backup
vim.opt.clipboard        = "unnamedplus" -- Sync clipboard between OS and Neovim
vim.opt.fileencoding     = "utf-8"       -- The encoding written to a file
vim.opt.fileformat       = "unix"
vim.opt.mouse            = "a"           -- Allow the mouse to be used in neovim
vim.opt.swapfile         = false
vim.opt.smoothscroll     = true
vim.opt.switchbuf        = "usetab" -- Use already opened buffers when switching
vim.opt.timeout          = true
vim.opt.timeoutlen       = 300      -- Decrease mapped sequence wait time
vim.opt.updatetime       = 250      -- Decrease update time
vim.opt.undofile         = true     -- Enable persistent undo
vim.opt.writebackup      = false    -- Don't store backup

-- UI options
vim.opt.breakindent      = true -- Indent wrapped lines to match line start
vim.opt.breakindentopt   = "list:-1" -- Add padding for lists when 'wrap' is on
vim.opt.cmdheight        = 1 -- More space in the neovim command line for displaying messages
vim.opt.colorcolumn      = "+1" -- Draw colored column one step to the right of desired maximum width
vim.opt.conceallevel     = 1 -- So that `` is visible in markdown files
vim.opt.cursorline       = true -- Highlight the current line
vim.opt.cursorlineopt    = { "screenline", "number" } -- Show cursor line only screen line when wrapped
vim.opt.fillchars        = table.concat({ "eob: ", "fold:╌" }, ",")
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done
vim.opt.hlsearch       = false -- Highlight all matches on previous search pattern
vim.opt.inccommand     = "split" -- Preview substitutions live in a seperate split!
vim.opt.linebreak      = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.opt.listchars      = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",") -- Special text symbols
vim.opt.number         = true -- Make line numbers default
vim.opt.numberwidth    = 4 -- Minimal number of columns to use for the line number {default 4}
vim.opt.pumheight      = 10 -- Pop up menu height
vim.opt.relativenumber = true -- Relative line numbers, to help with jumping
vim.opt.ruler          = false -- Don't show the cursor position
vim.opt.scrolloff      = 999 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.shortmess:append("c") -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.showcmd       = false -- Hide (partial) command in the last line of the screen (for performance)
vim.opt.showmode      = false -- We don't need to see things like -- INSERT -- anymore, this is showed on statusline plugin
vim.opt.showtabline   = 0 -- Never show tabs
vim.opt.sidescrolloff = 10 -- Minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.signcolumn    = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.opt.splitbelow    = true -- Force all horizontal splits to go below current window
vim.opt.splitright    = true -- Force all vertical splits to go to the right of current window

if vim.fn.has("nvim-0.10") == 0 then
	vim.opt.termguicolors = true -- Enable gui colors (Neovim>=0.10 does this automatically)
end

if vim.fn.has("nvim-0.11") == 1 then
	vim.opt.winborder = "rounded" -- Use rounded as default border
end

vim.opt.wrap       = false -- Display lines as one long line

-- Editing options
vim.opt.autoindent = true                       -- Use auto indent
vim.opt.expandtab  = true                       -- Convert tabs to spaces
vim.opt.ignorecase = true                       -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.incsearch  = true                       -- Highlight while typing a search pattern
vim.opt.infercase  = true                       -- Infer letter cases for a richer built-in keyword completion
vim.opt.iskeyword:append("@,48-57,_,192-255,-") -- Treat dash separated words as a word text object
vim.opt.shiftwidth  = 4                         -- The number of spaces inserted for each indentation
vim.opt.smartcase   = true                      -- Don't ignore case when searching if pattern has upper case
vim.opt.smartindent = true                      -- Do smart autoindenting when starting a new line
vim.opt.softtabstop = 4                         -- Number of spaces that a <Tab> counts for while performing editing
vim.opt.tabstop     = 4                         -- Number of spaces that a <Tab> in the file counts for.
vim.opt.virtualedit = "block"                   -- Enable virtual edit for visual block mode
vim.opt.whichwrap:append("<,>,[,],h,l")         -- Keys allowed to move to the previous/next line when the beginning/end of line is reached

vim.opt.completeopt = { "menuone", "noselect" } -- Show popup even with one item and don't autoselect first

if vim.fn.has("nvim-0.11") == 1 then
	vim.opt.completeopt = { "menuone", "noselect", "fuzzy", "nosort" } -- Use fuzzy matching for built-in completion
end

-- Folds options
vim.opt.foldmethod     = "indent" -- Set "indent" folding method
vim.opt.foldlevel      = 1        -- Display all folds except top ones
vim.opt.foldnestmax    = 10       -- Create folds only for some number of nested levels
vim.g.markdown_folding = 1        -- Use folding by heading in markdown files

if vim.fn.has("nvim-0.10") == 1 then
	vim.opt.foldtext = "" -- Use underlying text with its highlighting
end

-- Diagnostics configuration
vim.diagnostic.config({
	virtual_text = true, -- This enables LSP diagnostics to be shown inline
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})
