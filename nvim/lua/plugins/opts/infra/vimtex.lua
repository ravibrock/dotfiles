vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_view_sioyek_options = "--new-window"
vim.g.tex_flavor = "latex"
vim.g.vimtex_fold_enabled = 2
-- vim.g.vimtex_compiler_latexmk = { options = { "-shell-escape" } } -- Disable by default
vim.keymap.set("i", "<C-x><CR>", "<plug>(vimtex-delim-close)", { silent = true, desc = "Close delimiter" })
vim.opt.conceallevel = 2 -- Enable VimTeX conceal

-- Replace double quotes with `` and ''
local function quotes()
    local line = vim.fn.getline(".")
    local position = vim.api.nvim_win_get_cursor(0)[2] + 1
    local _, quote_count = string.sub(line, 1, position):gsub('"', '')
    vim.cmd('silent! s/\\"\\([^\\"]*\\)\\"/\\`\\`\\1\'\'/')
    local new_line = vim.fn.getline(".")
    if line ~= new_line then vim.fn.cursor({ ".", position + quote_count }) end
end
vim.api.nvim_create_user_command("VimtexQuotes", quotes, {})

vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventQuit",
    desc = "VimTeX: Clean up auxiliary files on exit",
    command = "VimtexClean",
})
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventViewReverse",
    desc = "VimTeX: Return focus to vim after inverse search trigger in PDF",
    command = vim.fn.system("osascript -e 'activate application \"iTerm\"'"),
})
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventViewReverse",
    desc = "VimTeX: Send cursor to last column after inverse search trigger in PDF",
    command = "lua vim.fn.cursor(vim.fn.line('.'), vim.fn.col('$'))",
})
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    desc = "VimTeX: Reload to fix symlink behavior",
    command = "silent! VimtexReload",
})
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = { "*.tex", "*.bib" },
    desc = "VimTeX: Auto replace double quotes in current line with `` and ''",
    command = "VimtexQuotes",
})
