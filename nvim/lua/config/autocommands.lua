local autocmd = vim.api.nvim_create_autocmd

-- Stop commenting new lines
autocmd("BufEnter", { command = "setlocal formatoptions-=ro" })

-- Enable autoread
vim.opt.autoread = true
autocmd({ "FocusGained", "BufEnter" }, { command = "silent! checktime" })

-- Automatically enter insert mode in terminal
vim.api.nvim_create_augroup("TerminalInsert", {})
autocmd("TermOpen", { command = "startinsert" })
autocmd("TermOpen", { command = "setlocal nonumber norelativenumber" })

-- Adjust highlighting
autocmd({ "BufNewFile", "BufReadPre" }, {
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

-- Clear command palette when cursor moves or entering insert mode
autocmd({ "CursorMoved", "InsertEnter", "TermOpen" }, { command = "echon ''" })

-- Set filetypes
autocmd({ "BufRead", "BufNewFile" }, { command = "if expand('%:e') == 'err' | set ft=log | endif" })
autocmd({ "BufRead", "BufNewFile" }, { command = "if expand('%:e') == 'out' | set ft=log | endif" })
autocmd({ "BufRead", "BufNewFile" }, { command = "if getline(1) =~ '^execve' | set ft=strace | endif" })
autocmd(
    { "BufRead", "BufNewFile" },
    { command = "if match(expand('%:t'), '\\.gitalias$') != -1 | set ft=gitconfig | endif" }
)

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
