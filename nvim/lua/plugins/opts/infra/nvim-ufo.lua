vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local M = {}
M.ffi = require("ffi")

M.ffi.cdef([[
	typedef struct {} Error;
	typedef struct {} win_T;
	typedef struct {
		int start;  // line number where deepest fold starts
		int level;  // fold level, when zero other fields are N/A
		int llevel; // lowest level that starts in v:lnum
		int lines;  // number of lines from v:lnum to end of closed fold
	} foldinfo_T;
	foldinfo_T fold_info(win_T* wp, int lnum);
	win_T *find_window_by_handle(int Window, Error *err);
]])

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

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local language_servers = require("lspconfig").util.available_servers()
for _, ls in ipairs(language_servers) do
    require("lspconfig")[ls].setup({
        capabilities = capabilities
    })
end

require("ufo").setup()
