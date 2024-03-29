-- Map leader and localleader
vim.g.maplocalleader = ";"
vim.g.mapleader = " "

-- Remap window navigation commands
vim.keymap.set({ "n", "v" }, "<C-h>", "<C-w>h", { noremap = true, desc = "Navigate to left window" })
vim.keymap.set({ "n", "v" }, "<C-j>", "<C-w>j", { noremap = true, desc = "Navigate to lower window" })
vim.keymap.set({ "n", "v" }, "<C-k>", "<C-w>k", { noremap = true, desc = "Navigate to upper window" })
vim.keymap.set({ "n", "v" }, "<C-l>", "<C-w>l", { noremap = true, desc = "Navigate to right window" })

-- Remap arrow keys in insert and command mode
vim.keymap.set({ "i", "c" }, "<C-h>", "<Left>", { noremap = true, desc = "Move cursor left" })
vim.keymap.set({ "i", "c" }, "<C-j>", "<Down>", { noremap = true, desc = "Move cursor down" })
vim.keymap.set({ "i", "c" }, "<C-k>", "<Up>", { noremap = true, desc = "Move cursor up" })
vim.keymap.set({ "i", "c" }, "<C-l>", "<Right>", { noremap = true, desc = "Move cursor right" })

-- Spellcheck with <C-m> in insert mode
local function spellcheck()
    local colnr = vim.fn.col(".")
    local linenr = vim.fn.line(".")
    --- @diagnostic disable-next-line: param-type-mismatch
    local length = string.len(vim.fn.getline("."))
    local window = vim.fn.winsaveview()
    local foldstatus = vim.opt.foldenable
    vim.opt.foldenable = false
    vim.cmd("normal! [s")
    if linenr == vim.fn.line(".") then vim.cmd("normal! 1z=") end
    vim.fn.cursor({ linenr, "." })
    --- @diagnostic disable-next-line: param-type-mismatch
    local position = string.len(vim.fn.getline(".")) - (length - colnr)
    vim.opt.foldenable = foldstatus
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.fn.winrestview(window)
    vim.fn.cursor({ ".", position })
end
vim.keymap.set("i", "<C-m>", spellcheck, { noremap = true, desc = "Fix last typo" })

-- Export via pandoc
vim.api.nvim_create_user_command(
    "PandocExport",
    function(filename)
        if filename["args"] == "" then
            filename = vim.fn.input("Filename: ", "", "file")
            vim.cmd("normal! :<CR>")
        else
            filename = filename["args"]
        end
        if filename == "" then return end
        vim.cmd("!pandoc -s % -o " .. filename)
    end,
    { nargs = "?", complete = "file" }
)
vim.keymap.set("n", "<leader>pe", "<CMD>PandocExport<CR>", { noremap = true, desc = "Export file via pandoc" })

-- Center screen when searching with n/N
vim.keymap.set("n", "n", "nzz", { noremap = true, desc = "Center screen when searching forwards" })
vim.keymap.set("n", "N", "Nzz", { noremap = true, desc = "Center screen when searching backwards" })

-- Clear search results with <CR> in normal mode
vim.keymap.set("n", "<CR>", "<CMD>nohlsearch <BAR> echon ''<CR><CR>", { silent = true, noremap = true, desc = "Clear search highlight" })

-- Go to beginning of line when hitting { or } in normal mode
vim.keymap.set("n", "{", "{0", { noremap = true, desc = "Go to last newline" })
vim.keymap.set("n", "}", "}0", { noremap = true, desc = "Go to next newline" })

-- Switch buffers with <C-U> and <C-I> in normal mode
vim.keymap.set("n", "<C-U>", "<CMD>BufferPrevious<CR>", { noremap = true, desc = "Switch to previous buffer" })
vim.keymap.set("n", "<C-I>", "<CMD>BufferNext<CR>", { noremap = true, desc = "Switch to next buffer" })

-- Enable mouse support
vim.opt.mouse = "a"

-- Delete word with <M-BS> in insert mode
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true, desc = "Delete word" })

-- Open current file in MacOS Finder
vim.keymap.set("n", "<leader>fo", "<CMD>silent! !open -R %<CR>", { noremap = true, desc = "Show file in Finder" })
