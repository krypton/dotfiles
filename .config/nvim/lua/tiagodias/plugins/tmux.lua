-- This integrates with the same package used on TPM package manager on .tmux.conf
local M = {
	"aserowy/tmux.nvim",
}

M.config = function()
	local tmux = require("tmux")

	tmux.setup()
end

return M
