local builtin = require("statuscol.builtin")
require("statuscol").setup({
    ft_ignore = { "alpha" },
    bt_ignore = { "terminal" },
    clickmod = "c",
    relculright = true,
    segments = {
        {
            sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 2, auto = true },
            click = "v:lua.ScSa",
        },
        {
            sign = { name = { ".*"  }, maxwidth = 1, colwidth = 2, auto = true },
            click = "v:lua.ScSa",
        },
        {
            text = { builtin.lnumfunc, " " },
            click = "v:lua.ScLa",
        },
        {
            text = { function(args) return builtin.foldfunc(args):gsub(" ", "│") end, " " },
            maxwidth = 1,
            colwidth = 2,
            click = "v:lua.ScFa",
        },
    },
})
