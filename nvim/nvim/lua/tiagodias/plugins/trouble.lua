return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        local trouble = require("trouble")
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }
        keymap.set("n", "<leader>xx", function() trouble.open() end, opts)
        keymap.set("n", "<leader>xw", function() trouble.open("workspace_diagnostics") end, opts)
        keymap.set("n", "<leader>xd", function() trouble.open("document_diagnostics") end, opts)
        keymap.set("n", "<leader>xq", function() trouble.open("quickfix") end, opts)
        keymap.set("n", "<leader>xl", function() trouble.open("loclist") end, opts)
        -- keymap.set("n", "gR", function() trouble.open("lsp_references") end, opts)
    end
}
