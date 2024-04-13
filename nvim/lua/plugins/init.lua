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
    spec = { import = "plugins.startup" },
    install = { colorscheme = { "catppuccin" } },
    lockfile = "/dev/null", -- Disable lockfile; not used
    defaults = {
        lazy = false,
        version = false,
    },
    change_detection = { notify = false },
    checker = {
        enabled = false,
        notify = false,
    },
    ui = { backdrop = 100 },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

vim.cmd("colorscheme catppuccin")
