local M = {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
}

M.config = function()
	local barbecue = require("barbecue")

	barbecue.setup({
		theme = "tokyonight",
		attach_navic = false,
		show_dirname = true,
		show_basename = true,
	})
end

return M
