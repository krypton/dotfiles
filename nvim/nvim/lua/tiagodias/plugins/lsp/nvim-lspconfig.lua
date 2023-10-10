return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',                   tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Neovim api and docs support for lua
    require("neodev").setup()

    vim.lsp.set_log_level("debug")
  end
}
