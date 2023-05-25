local autocmd = vim.api.nvim_create_autocmd

-- Stop commenting new lines
autocmd('BufEnter', {
    command = ":setlocal formatoptions-=ro"
})

-- Enable autoread
vim.opt.autoread = true
autocmd('FocusGained, BufEnter', {
    command = ":silent! checktime"
})
