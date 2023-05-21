-- Map leader key to space
vim.g.mapleader = " "

-- Visual mode searching for current selection
vim.keymap.set('v', '*', ':<C-u>call VisualSelection("", "")<CR>/<C-R>=@/<CR><CR>')
vim.keymap.set('v', '"', ':<C-u>call VisualSelection("", "")<CR>?<C-R>=@/<CR><CR>')

-- Remap window navigation commands
vim.keymap.set({'n', 'v'}, '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Enable mouse support
vim.opt.mouse = 'a'
