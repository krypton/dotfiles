-- This integrates with the same package used on TPM package manager on .tmux.conf
return {
    "aserowy/tmux.nvim",
    config = function()
        local tmux = require("tmux")

        tmux.setup()
    end
}

