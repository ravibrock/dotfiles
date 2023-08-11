require("mason-null-ls").setup({
    ensure_installed = {
        -- C, C++
        "clangd",
        "cpptools",

        -- CSS/HTML/JSON
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "tidy",

        -- JavaScript/TypeScript
        "typescript-language-server",
        "prettier",

        -- LaTeX
        "textidote",

        -- Lua
        "lua-language-server",
        "stylua",

        -- Python
        "pylint",
        "pyright",

        -- Rust
        "rust-analyzer",

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
