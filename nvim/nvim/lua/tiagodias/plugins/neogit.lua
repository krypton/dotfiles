return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"nvim-telescope/telescope.nvim", -- optional
		"sindrets/diffview.nvim", -- optional
	},
	config = true,
}
-- return {
-- 	"sindrets/diffview.nvim",
-- 	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
-- 	opts = {},
-- 	keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
-- }
