return {
    "lukas-reineke/virt-column.nvim",
    opts = {},
    config = function()
        local virt = require("virt-column")

        virt.setup()
    end
}

