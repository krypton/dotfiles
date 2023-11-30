return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	options = {
		mode = "buffers",
		numbers = "ordinal",
		truncate_names = false, -- This allows us to open buffers with the same filename
		offsets = {
			{
				filetype = "NvimTree",
				text = " File Explorer",
				highlight = "Directory",
				separator = false,
			},
		},
	},
}
