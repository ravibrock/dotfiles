require("mason-null-ls").setup({
    ensure_installed = {
        "beautysh",
        "misspell",
        "tidy",
        "prettier",
        "shellcheck",
        "stylua",
        "vint",
        "zsh",
    },
    automatic_installation = true,
    handlers = {},
})
