-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
   "m4xshen/autoclose.nvim",       
   "windwp/nvim-ts-autotag",
   {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
   },
   "tpope/vim-sleuth",
   "nacro90/numb.nvim",
   {
      "numToStr/Comment.nvim",
      opts = {},
      lazy = false,
   },
   {
      "lukas-reineke/indent-blankline.nvim",
      branch = "v3",
   },
   "lewis6991/gitsigns.nvim",
   {
      "NeogitOrg/neogit",
      dependencies = {
         "nvim-lua/plenary.nvim",         -- required
         "nvim-telescope/telescope.nvim", -- optional
         "sindrets/diffview.nvim",        -- optional
      },
      config = true
   },
   "lukas-reineke/virt-column.nvim",
   "m4xshen/smartcolumn.nvim",
   {
      "akinsho/bufferline.nvim",
      version = "v3.*",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {},
   },
   {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
         "SmiteshP/nvim-navic",
         "nvim-tree/nvim-web-devicons", -- optional dependency
      },
   },
   {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
         "nvim-tree/nvim-web-devicons",
      },
   },
   {
      "shortcuts/no-neck-pain.nvim",
      version = "*",
   },
   {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.3",
      dependencies = {
         "nvim-lua/plenary.nvim",
         -- Fuzzy Finder Algorithm which requires local dependencies to be built.
         -- Only load if `make` is available. Make sure you have the system
         -- requirements installed.
         {
           'nvim-telescope/telescope-fzf-native.nvim',
           -- NOTE: If you are having trouble with this installation,
           --       refer to the README for telescope-fzf-native for more instructions.
           build = 'make',
           cond = function()
             return vim.fn.executable 'make' == 1
           end,
         },
      },
   },
   {
      -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
         "nvim-treesitter/nvim-treesitter-textobjects",
         "nvim-treesitter/nvim-treesitter-context"
      },
      build = ':TSUpdate',
   },
   {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
   },
   {
      "rcarriga/nvim-notify",
      opts = {},
      config = function()
         vim.notify = require("notify")
      end,
   },
   {
      "aznhe21/actions-preview.nvim",
      config = function()
         vim.keymap.set({ "v", "n" }, "<Leader>ca", require("actions-preview").code_actions)
      end,
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = {
         "nvim-tree/nvim-web-devicons"
      },
   },
   {
      'folke/which-key.nvim',
      opts = {}
   }
})
