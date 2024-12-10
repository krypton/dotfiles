return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	enabled = false,
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		---@diagnostic disable-next-line: missing-fields
		comment.setup({
			-- for commenting tsx and jsx files
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}
