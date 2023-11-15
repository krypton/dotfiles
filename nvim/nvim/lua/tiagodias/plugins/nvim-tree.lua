return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvimtree = require("nvim-tree")

		nvimtree.setup({
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- OR use all default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- add your mappings
				vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
				vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end,
			sync_root_with_cwd = false,
			respect_buf_cwd = false,
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = false, -- Turn into false from true by default
			},
			update_focused_file = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			view = {
				width = {
					min = 30,
					max = -1,
				},
				side = "left",
			},
		})
	end,
}
