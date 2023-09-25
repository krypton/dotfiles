require("bufferline").setup({
   options = {
      mode = "buffers",
      numbers = "ordinal",
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
