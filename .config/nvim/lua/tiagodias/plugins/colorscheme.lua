return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "moon",
			dark_variant = "moon",
		})
		vim.cmd.colorscheme("rose-pine")
		local highlights = {
			"Normal",
			"NormalFloat",
			"LineNr",
			"Folded",
			"NonText",
			"SpecialKey",
			"VertSplit",
			"SignColumn",
			"EndOfBuffer",
			"TablineFill", -- this is specific to how I like my tabline to look like
		}
		for _, name in pairs(highlights) do
			vim.cmd.highlight(name .. " guibg=none ctermbg=none")
		end
	end,
}
