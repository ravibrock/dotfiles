--- @diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "c",
        "css",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "sql",
        "ssh_config",
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
