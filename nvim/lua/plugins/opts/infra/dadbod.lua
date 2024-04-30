vim.g.db_ui_use_nerd_fonts = 1
vim.api.nvim_create_user_command("DBUITrigger",
    function()
        vim.cmd("DBUIToggle")
        vim.cmd("silent! bd! dbout")
        if vim.fn.expand("%:p"):find("^/private/var") and vim.fn.bufwinnr("dbui") == -1 then
            vim.cmd("silent! b#")
        end
    end,
    { nargs = 0, desc = "Trigger Dadbod UI" }
)

vim.api.nvim_create_augroup("DBUI", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = "DBUI",
    pattern = { "*.*sql" },
    callback = function()
        require("cmp").setup.buffer({ sources = {{ name = "vim-dadbod-completion" }} })
    end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = "DBUI",
    pattern = { "*.dbout" },
    callback = function()
        vim.opt_local.wrap = false
    end,
})
