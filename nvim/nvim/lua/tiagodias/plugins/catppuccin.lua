return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local catppuccin = require("catppuccin")

        catppuccin.setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            custom_highlights = function(colors)
                return {
                    VertSplit = { fg = colors.surface0 },
                }
            end
        })

        -- setup must be called before loading
        vim.cmd.colorscheme("catppuccin")
    end
}

