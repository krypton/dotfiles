return {
  "windwp/nvim-ts-autotag",
  config = function()
    -- import nvim-autopairs
    local autotag = require("nvim-ts-autotag")

    autotag.setup()
  end,
}

