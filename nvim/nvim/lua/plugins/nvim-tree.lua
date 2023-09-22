local function my_on_attach(bufnr)
   local api = require('nvim-tree.api')

   local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
   end

   -- OR use all default mappings
   api.config.mappings.default_on_attach(bufnr)

   -- add your mappings
   vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
   vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
end

return {
   {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
         "nvim-tree/nvim-web-devicons",
      },
      config = function()
         require("nvim-tree").setup {
            on_attach = my_on_attach,
            update_focused_file = {
               enable = true,
               update_cwd = true,
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
               width = 30,
               side = "left",
           },
         }
      end,
   },
}
