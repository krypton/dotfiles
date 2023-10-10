return {
  "m4xshen/smartcolumn.nvim",
  opts = {},
  config = function()
    local smartcolumn = require("smartcolumn")

    smartcolumn.setup({
      disabled_filetypes = { "NvimTree", "lazy", "mason", "help" },
      scope = "window",
    })
  end
}

