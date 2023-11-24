local null_ls = require("null-ls")
null_ls.setup({
    diagnostics_format = "#{m}",
    sources = {
        null_ls.builtins.formatting.beautysh,
        null_ls.builtins.diagnostics.misspell,
        null_ls.builtins.diagnostics.tidy,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.hover.printenv.with({
            filetypes = { "sh", "dosbatch", "ps1", "zsh" },
        }),
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.vint,
        null_ls.builtins.diagnostics.zsh,
    },
})
