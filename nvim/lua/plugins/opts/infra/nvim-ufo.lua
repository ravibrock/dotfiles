vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local language_servers = require("lspconfig").util.available_servers()
for _, ls in ipairs(language_servers) do
    require("lspconfig")[ls].setup({ capabilities = capabilities })
end

require("ufo").setup()
