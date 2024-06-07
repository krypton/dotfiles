-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- netrw global settings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.skip_ts_context_commentstring_module = true

-- enables the experimental Lua module loader
vim.loader.enable()

-- make line numbers default
vim.opt.number = true

-- relative line numbers, to help with jumping
vim.opt.relativenumber = true

-- allow the mouse to be used in neovim
vim.opt.mouse = "a"

-- we don't need to see things like -- INSERT -- anymore, this is showed on lualine
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- enable persistent undo
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- always show the sign column, otherwise it would shift the text each time
vim.opt.signcolumn = "yes"

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Decrease update time
vim.opt.updatetime = 250

-- force all horizontal splits to go below current window
vim.opt.splitbelow = true

-- force all vertical splits to go to the right of current window
vim.opt.splitright = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Highlight while typing a search pattern
vim.opt.incsearch = true

-- highlight the current line
vim.opt.cursorline = true

-- Do smart autoindenting when starting a new line
vim.opt.smartindent = true

-- Convert tabs to spaces
vim.opt.expandtab = true

-- The number of spaces inserted for each indentation
vim.opt.shiftwidth = 4

-- Number of spaces that a <Tab> in the file counts for.
vim.opt.tabstop = 4

-- Number of spaces that a <Tab> counts for while performing editing
vim.opt.softtabstop = 4

-- creates a backup file
vim.opt.backup = false
-- more space in the neovim command line for displaying messages
vim.opt.cmdheight = 1
-- mostly just for cmp
vim.opt.completeopt = { "menuone", "noselect" }
-- so that `` is visible in markdown files
vim.opt.conceallevel = 1
-- the encoding written to a file
vim.opt.fileencoding = "utf-8"
-- highlight all matches on previous search pattern
vim.opt.hlsearch = false
-- pop up menu height
vim.opt.pumheight = 0
-- always show tabs
vim.opt.showtabline = 0
-- creates a swapfile
vim.opt.swapfile = false
-- set term gui colors (most terminals support this)
vim.opt.termguicolors = true
vim.opt.timeout = true
-- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.writebackup = false
-- only the last window will always have a status line
vim.opt.laststatus = 3
-- hide (partial) command in the last line of the screen (for performance)
vim.opt.showcmd = false
-- hide the line and column number of the cursor position
vim.opt.ruler = true
-- minimal number of columns to use for the line number {default 4}
vim.opt.numberwidth = 4
-- display lines as one long line
vim.opt.wrap = false
-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10
-- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.sidescrolloff = 10
vim.opt.linebreak = true
vim.opt.fileformat = "unix"
-- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.fillchars.eob = " "
-- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.shortmess:append("c")
-- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.whichwrap:append("<,>,[,],h,l")
-- treats words with `-` as single words
vim.opt.iskeyword:append("-")
-- This is a sequence of letters which describes how automatic formatting is to be done
vim.opt.formatoptions:remove({ "c", "r", "o" })
