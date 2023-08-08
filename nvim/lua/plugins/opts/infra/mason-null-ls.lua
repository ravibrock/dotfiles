require("mason-null-ls").setup({
    ensure_installed = {
        -- CSS/HTML/JSON
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "tidy",

        -- LaTeX
        "textidote",

        -- Lua
        "lua-language-server",
        "stylua",

        -- Python
        "pylint",
        "pyright",

        -- Shell
        "beautysh",
        "shellcheck",
        "zsh",

        -- Typos
        "misspell",

        -- Vim
        "vim-language-server",
        "vint",
    },
    automatic_installation = true,
    handlers = {},
})
