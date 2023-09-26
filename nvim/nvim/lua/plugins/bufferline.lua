require("bufferline").setup({
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
})
