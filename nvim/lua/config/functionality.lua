-- History
vim.opt.history=100

-- Address checkhealth recommendation
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python3_host_prog = os.getenv("HOME") .. "/miniforge3/bin/python3"

-- Filetype plugins
vim.opt.filetype = "on"
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.smartindent = true
vim.opt.ffs = { "unix", "dos", "mac" }

-- Ignore compiled files
vim.opt.wildignore = { "*.o", "*~", "*.pyc", "*pycache*", "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store" }

-- Configure working directory
vim.opt.autochdir = true

-- Text encoding
vim.opt.encoding = "utf-8"

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo/"

-- Spellchecking
vim.opt.spellfile = os.getenv("HOME") .. "/.vim/spell/spellfile.utf-8.add"
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Use spaces rather than tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Enables yank to system clipboard, use `unnamedplus` if broken on Linux
vim.opt.clipboard = "unnamed"

-- Configure search
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.magic = true
vim.opt.regexpengine = 0
vim.opt.smartcase = true

-- Set hidden buffers
vim.opt.hidden = true

-- Don"t redraw
vim.opt.lazyredraw = true

-- Backup files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Run given command and send output to main register
vim.api.nvim_create_user_command(
    "Copy",
    function(cmd) vim.cmd("redir @* | " .. cmd["args"] .. " | redir END") end,
    { nargs = 1 }
)
