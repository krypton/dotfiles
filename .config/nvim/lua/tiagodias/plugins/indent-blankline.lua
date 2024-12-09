return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	enabled = false,
	opts = {},
	config = function()
		local ibl = require("ibl")

		ibl.setup()
	end,
}
