return {
   {
      "catppuccin/nvim",
      name = "catppuccin",
      opts = {
         flavour = "mocha",
         custom_highlights = function(colors)
            return {
               VertSplit = { fg = colors.surface0 },
            }
         end,
      },
      init = function()
         vim.cmd.colorscheme("catppuccin")
      end,
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
         vim.keymap.set(
            { "v", "n" },
            "<Leader>ca",
            require("actions-preview").code_actions
         )
      end,
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
         options = {
            theme = "catppuccin",
            globalstatus = true,
         },
         sections = {
            lualine_c = {},
         },
      },
      init = function()
         vim.opt.showmode = false
      end,
   },
}
