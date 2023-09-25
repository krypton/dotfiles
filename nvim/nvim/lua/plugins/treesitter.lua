require("nvim-treesitter.configs").setup({
   auto_install = true,
   ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "javascript",
      "html",
      "css",
      "ruby",
   },
   highlight = { enable = true },
   indent = { enable = true },
   autotag = { enable = true },
})