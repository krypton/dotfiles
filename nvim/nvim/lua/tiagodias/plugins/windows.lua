return {
	"anuvyklack/windows.nvim",
	event = "WinNew",
	dependencies = {
		{ "anuvyklack/middleclass" },
	},
	config = function()
		require("windows").setup()
	end,
}
