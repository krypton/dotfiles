-- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
return {
	"tpope/vim-sleuth",
	config = function()
		vim.g.sleuth_automatic = 1
		vim.g.sleuth_automatic_min_lines = 200
		vim.g.sleuth_max_lines = 2000
	end,
}
