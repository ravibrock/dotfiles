-- Configure terminal title
vim.opt.title = true
vim.opt.titlestring = "%F %r %m"
vim.opt.laststatus = 2

-- Configure line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.cmd("highlight LineNr ctermfg=gray")
vim.cmd("highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE")
vim.cmd("highlight CursorLineNr cterm=bold ctermbg=NONE ctermfg=white")

-- Enable syntax highlighting
vim.cmd("syntax enable")
vim.cmd("highlight MatchParen cterm=none ctermbg=white ctermfg=black")
vim.cmd("highlight! link SignColumn LineNr")

-- Configure foldcolumn characters
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]

-- Show matching brackets
vim.opt.showmatch = true
vim.opt.mat = 2

-- Show commands
vim.opt.showcmd = true

-- Hide mode notification
vim.opt.showmode = false

-- Disable bells
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.tm = 500
