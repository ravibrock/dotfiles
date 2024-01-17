local autocmd = vim.api.nvim_create_autocmd

-- Stop commenting new lines
autocmd("BufEnter", { command = "setlocal formatoptions-=ro" })

-- Enable autoread
vim.opt.autoread = true
autocmd({ "FocusGained", "BufEnter" }, { command = "silent! checktime" })

-- Adjust highlighting
autocmd("BufReadPre", {
    callback = function()
        vim.cmd("highlight clear SpellBad")
        vim.cmd("highlight clear SpellCap")
        vim.cmd("highlight clear SpellRare")
        vim.cmd("highlight clear SpellLocal")
        vim.cmd("highlight clear DiagnosticUnderlineError")
        vim.cmd("highlight clear DiagnosticUnderlineWarn")
        vim.cmd("highlight clear DiagnosticUnderlineInfo")
        vim.cmd("highlight clear DiagnosticUnderlineHint")
        vim.cmd("highlight clear DiagnosticUnderlineOk")
        vim.cmd("highlight! link FoldColumn LineNr")
    end,
})

-- Set filetype for output, error, and strace files
autocmd("BufRead", { command = "if expand('%:e') == 'out' | set ft=log | endif" })
autocmd("BufRead", { command = "if expand('%:e') == 'err' | set ft=log | endif" })
autocmd("BufRead", { command = "if getline(1) =~ '^execve' | set ft=strace | endif" })

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        local old_query = vim.fn.getreg("/")
        vim.cmd("silent %s/\\s\\+$//e")
        vim.fn.setpos(".", save_cursor)
        vim.fn.setreg("/", old_query)
    end,
})
