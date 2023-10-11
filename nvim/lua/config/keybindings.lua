-- Map leader key to space
vim.g.mapleader = " "

-- Remap window navigation commands
vim.keymap.set({"n", "v"}, "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set({"n", "v"}, "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set({"n", "v"}, "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set({"n", "v"}, "<C-l>", "<C-w>l", { noremap = true })

-- Remap arrow keys in insert and command mode
vim.keymap.set({"i", "c"}, "<C-h>", "<Left>", { noremap = true })
vim.keymap.set({"i", "c"}, "<C-j>", "<Down>", { noremap = true })
vim.keymap.set({"i", "c"}, "<C-k>", "<Up>", { noremap = true })
vim.keymap.set({"i", "c"}, "<C-l>", "<Right>", { noremap = true })

-- Spellcheck with <C-m> in insert mode
vim.keymap.set("i", "<C-m>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { noremap = true })

-- Go to beginning of line when hitting { or } in normal mode
vim.keymap.set("n", "{", "{0", { noremap = true })
vim.keymap.set("n", "}", "}0", { noremap = true })

-- Enable mouse support
vim.opt.mouse = "a"
