return {
    "aznhe21/actions-preview.nvim",
    config = function()
        local actions = require("actions-preview")

        vim.keymap.set({ "v", "n" }, "<Leader>ca", actions.code_actions)
    end,
}

