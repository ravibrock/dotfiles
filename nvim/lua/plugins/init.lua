local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins.startup" },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    checker = { enabled = true },
    ui = { border = "rounded" },
})

vim.cmd("colorscheme catppuccin")
require("lazy").sync({ show = false })
