vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

local M = {}

function M.fold_col()
	local Cfold_info = M.ffi.C.fold_info
	local wp = M.ffi.C.find_window_by_handle(vim.g.statusline_winid, M.ffi.new("Error"))
	local foldinfo = Cfold_info(wp, vim.v.lnum)
	if foldinfo.start == vim.v.lnum then
		if vim.fn.foldclosed(vim.v.lnum) ~= -1 then
			return [[%#StatusColumnFoldClosed#]] .. [[▶]] .. [[%*]]
		end
	end
	return ""
end

vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

require("ufo").setup({
    provider_selector = function(_, ft, _)
        local nofoldlsp = { "markdown", "sh", "css", "html", "python" }
        if vim.tbl_contains(nofoldlsp, ft) then return { "treesitter", "indent" } end
        return { "lsp", "indent" }
    end,
})
