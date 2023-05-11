-- Opens symlinks in their target:
function follow_symlink()
    local file = vim.fn.expand('%:p')
    local real_file = vim.fn.resolve(file)
    if (string.match(real_file, '[^%d]+:/') or real_file == file) then
         return
    end
    vim.cmd('file ' .. real_file)
    vim.cmd('echohl WarningMsg | echomsg "Resolved symlink ' .. file .. ' --> ' .. real_file .. '" | echohl None')
    vim.cmd('silent! w!')  -- Workaround for 'file exists' error on write
end
vim.api.nvim_create_autocmd('BufRead', {
  command = "lua follow_symlink()"
})

-- Remove trailing whitespace on save
function clean_extra_spaces()
    local save_cursor = vim.fn.getpos('.')
    local old_query = vim.fn.getreg('/')
    vim.cmd('silent %s/\\s\\+$//e')
    vim.fn.setpos('.', save_cursor)
    vim.fn.setreg('/', old_query)
end
vim.api.nvim_create_autocmd('BufWritePre', {
  command = "lua clean_extra_spaces()"
})
