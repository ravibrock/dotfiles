vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_view_sioyek_options = "--new-window"
vim.g.tex_flavor = "latex"
vim.g.vimtex_imaps_enabled = 0
vim.g.vimtex_fold_enabled = 2
vim.g.vimtex_compiler_latexmk = {
    options = {
        "-file-line-error",
        "-interaction=nonstopmode",
        "-shell-escape",
        "-synctex=1",
        "-verbose",
    },
}
vim.keymap.set("i", "<C-x><CR>", "<plug>(vimtex-delim-close)", { silent = true, desc = "Close delimiter" })
vim.opt.conceallevel = 2 -- Enable VimTeX conceal

-- Set up autocommands for VimTeX
vim.api.nvim_create_augroup("VimTeX", {})
vim.api.nvim_create_autocmd("User", {
    group = "VimTeX",
    pattern = "VimtexEventCompileStopped",
    desc = "VimTeX: Clean up auxiliary files on exit",
    command = "VimtexClean",
})
vim.api.nvim_create_autocmd("User", {
    group = "VimTeX",
    pattern = "VimtexEventViewReverse",
    desc = "VimTeX: Return focus to vim after inverse search trigger in PDF",
    command = vim.fn.system("osascript -e 'activate application \"Ghostty\"'"),
})
vim.api.nvim_create_autocmd("User", {
    group = "VimTeX",
    pattern = "VimtexEventViewReverse",
    desc = "VimTeX: Center text vertically after inverse search trigger in PDF",
    command = "normal! zz",
})
vim.api.nvim_create_autocmd("User", {
    group = "VimTeX",
    pattern = "VimtexEventViewReverse",
    desc = "VimTeX: Send cursor to last column after inverse search trigger in PDF",
    --- @diagnostic disable-next-line: param-type-mismatch
    callback = function() vim.fn.cursor(".", vim.fn.col("$")) end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = "VimTeX",
    pattern = { "*.tex", "*.bib" },
    desc = "VimTeX: Auto replace double quotes in current line with `` and ''",
    callback = function()
        --- @diagnostic disable-next-line: param-type-mismatch
        local line, linenr = vim.fn.getline("."), vim.fn.line(".")
        local position = vim.api.nvim_win_get_cursor(0)[2] + 1
        local _, quote_count = string.sub(line, 1, position):gsub('"', "")
        vim.cmd('silent! %s/\\"\\([^\\"]*\\)\\"/\\`\\`\\1\'\'/')
        local new_line = vim.fn.getline(linenr)
        if line ~= new_line then vim.fn.cursor({ linenr, position + quote_count }) end
    end,
})
