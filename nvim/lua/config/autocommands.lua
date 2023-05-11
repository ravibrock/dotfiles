local autocmd = vim.api.nvim_create_autocmd

-- Configure working directory
autocmd('BufRead', {
  command = ":silent! lcd %:p:h"
})

-- Stop commenting new lines
autocmd('BufEnter', {
  command = ":setlocal formatoptions-=ro"
})

-- Return to last cursor position when reopening files
autocmd('BufReadPost', {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
})

-- Enable autoread
vim.opt.autoread = true
autocmd('FocusGained, BufEnter', {
  command = ":silent! checktime"
})
