require("mason-null-ls").setup({
    ensure_installed = {
        -- Assembly
        "asm-lsp",

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

        -- Markdown
        "marksman",

        -- Python
        "pylint",
        "pyright",

        -- R
        "r-languageserver",

        -- Rust
        "rust-analyzer",

        -- Shell
        "bash-language-server",
        "beautysh",
        "shellcheck",
        "zsh",

        -- Typos
        "misspell",

        -- Vim
        "vim-language-server",
        "vint",

        -- YAML
        "yaml-language-server",
    },
    automatic_installation = true,
    handlers = {},
})
