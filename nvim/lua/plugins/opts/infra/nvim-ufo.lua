vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

local M = {}

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

function M.fold_col()
	local Cfold_info = M.ffi.C.fold_info
	local wp = M.ffi.C.find_window_by_handle(vim.g.statusline_winid, M.ffi.new("Error"))
	local foldinfo = Cfold_info(wp, vim.v.lnum)
	if foldinfo.start == vim.v.lnum then
		if vim.fn.foldclosed(vim.v.lnum) ~= -1 then
			return "%#StatusColumnFoldClosed#" .. "▶" .. "%*"
		end
	end
	return ""
end

vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

---@diagnostic disable-next-line: missing-fields
require("ufo").setup({
    fold_virt_text_handler = handler,
    provider_selector = function(_, ft, _)
        if ft == "tex" then return "" end
        local nofoldlsp = { "markdown", "sh", "css", "html", "python" }
        if vim.tbl_contains(nofoldlsp, ft) then return { "treesitter", "indent" } end
        return { "lsp", "indent" }
    end,
})

vim.cmd("highlight Folded guibg=NONE")
