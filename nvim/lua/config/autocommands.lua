local autocmd = vim.api.nvim_create_autocmd

-- Stop commenting new lines
autocmd("BufEnter", {
    command = "setlocal formatoptions-=ro"
})

-- Enable autoread
vim.opt.autoread = true
autocmd("FocusGained, BufEnter", {
    command = "silent! checktime"
})

-- Opens symlinks in their target:
function follow_symlink()
    local file = vim.fn.expand("%:p")
    local real_file = vim.fn.resolve(file)
    if (string.match(real_file, "[^%d]+:/") or real_file == file) then
        return
    end
    vim.cmd("file " .. real_file)
    vim.cmd("echohl WarningMsg | echomsg 'Resolved symlink " .. file:gsub(os.getenv("HOME"), "~") .. " ——⟶ " .. real_file:gsub(os.getenv("HOME"), "~") .. "' | echohl None")
    vim.cmd("silent! w!")  -- Workaround for "file exists" error on write
end
autocmd("BufRead", {
    command = "lua follow_symlink()"
})

-- Disable highlighting
function clear_spellcheck()
    vim.cmd("highlight clear SpellBad")
    vim.cmd("highlight clear SpellCap")
    vim.cmd("highlight clear SpellRare")
    vim.cmd("highlight clear SpellLocal")
end
autocmd("BufReadPre", {
    command = "lua clear_spellcheck()"
})

-- Remove trailing whitespace on save
function clean_extra_spaces()
    local save_cursor = vim.fn.getpos(".")
    local old_query = vim.fn.getreg("/")
    vim.cmd("silent %s/\\s\\+$//e")
    vim.fn.setpos(".", save_cursor)
    vim.fn.setreg("/", old_query)
end
autocmd("BufWritePre", {
    command = "lua clean_extra_spaces()"
})
