return {
   {
      "tpope/vim-sleuth",
   },
   {
      "nacro90/numb.nvim",
      opts = {},
   },
--[[    {
      "sbdchd/neoformat",
      keys = {
         { "<Leader>fm", ":Neoformat<CR>" },
      },
   }, ]]
   {
      'numToStr/Comment.nvim',
      opts = {},
      lazy = false,
   },
   {
      "lukas-reineke/indent-blankline.nvim",
      branch = "v3",
      config = function()
         require("ibl").setup()
      end,
   },
}
