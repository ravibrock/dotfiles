---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "query",
        "racket",
        "regex",
        "rust",
        "vim",
        "vimdoc",
    },
    indent = { enable = true },
    highlight = {
        disable = { "latex" },
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    matchup = { enable = true },
})
