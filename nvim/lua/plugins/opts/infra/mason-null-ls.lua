require("mason-null-ls").setup({
    ensure_installed = {
        "beautysh",
        "misspell",
        "textidote",
        "tidy",
        "prettier",
        "pylint",
        "shellcheck",
        "stylua",
        "vint",
        "zsh",
    },
    automatic_installation = true,
    handlers = {},
})
