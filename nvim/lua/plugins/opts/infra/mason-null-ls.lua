local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
    ensure_installed = {
        "beautysh",
        "misspell",
        "tidy",
        "shellcheck",
        "stylua",
        "zsh",
    },
    automatic_installation = true,
    handlers = {},
})
null_ls.setup({
    sources = {
        null_ls.builtins.hover.printenv.with({
            filetypes = { "sh", "dosbatch", "ps1", "zsh" },
        }),
    },
})
