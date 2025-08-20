---@diagnostic disable: undefined-global
local M = {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
}

M.build = function()
	vim.fn["mkdp#util#install"]()
end

return M
