local null_ls = require("null-ls")
null_ls.setup({
    diagnostics_format = "#{m}",
    border = "rounded",
    sources = { null_ls.builtins.hover.printenv },
})
