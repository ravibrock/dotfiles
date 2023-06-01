-- Map leader key to space
vim.g.mapleader = " "

-- Remap window navigation commands
vim.keymap.set({"n", "v"}, "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Spellcheck with <C-l> in insert mode
vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true, silent = true })

-- Enable mouse support
vim.opt.mouse = "a"
