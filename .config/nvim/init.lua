require("tiagodias.core")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

local winborder = "rounded"
if vim.fn.exists("+winborder") == 1 and vim.o.winborder ~= "" then
    winborder = vim.opt.winborder:get()
    if vim.isarray(winborder) and #winborder == 1 then
        winborder = winborder[1]
    end
end

-- Setup lazy.nvim
require("lazy").setup({
    { import = "tiagodias.plugins" },
    { import = "tiagodias.plugins.lsp" },
}, {
    checker = {
        enabled = true,
        notify = false,
    },
    install = {
        colorscheme = { "tokyonight" },
    },
    change_detection = {
        notify = false,
    },
    ui = {
        enabled = true,
        theme = "tokyonight",
        border = winborder,
    },
})
