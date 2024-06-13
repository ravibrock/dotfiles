local function gotoBreakpoint(dir)
	local breakpoints = require("dap.breakpoints").get()
	if #breakpoints == 0 then
		vim.notify("No breakpoints set", vim.log.levels.WARN)
		return
	end
	local points = {}
	for bufnr, buffer in pairs(breakpoints) do
		for _, point in ipairs(buffer) do
			table.insert(points, { bufnr = bufnr, line = point.line })
		end
	end

	local current = {
		bufnr = vim.api.nvim_get_current_buf(),
		line = vim.api.nvim_win_get_cursor(0)[1],
	}

	local nextPoint
	for i = 1, #points do
		local isAtBreakpointI = points[i].bufnr == current.bufnr and points[i].line == current.line
		if isAtBreakpointI then
			local nextIdx = dir == "next" and i + 1 or i - 1
			if nextIdx > #points then nextIdx = 1 end
			if nextIdx == 0 then nextIdx = #points end
			nextPoint = points[nextIdx]
			break
		end
	end
	if not nextPoint then nextPoint = points[1] end

	vim.cmd(("buffer +%s %s"):format(nextPoint.line, nextPoint.bufnr))
end

return {
    { "<leader>db", "<CMD>DapToggleBreakpoint<CR>", mode = "n", desc = "DAP toggle breakpoint" },
    { "<leader>dl", "<CMD>DapStepInto<CR>", mode = "n", desc = "DAP step into" },
    { "<leader>dj", "<CMD>DapStepOver<CR>", mode = "n", desc = "DAP step over" },
    { "<leader>dh", "<CMD>DapStepOut<CR>", mode = "n", desc = "DAP step out" },
    {
        "<leader>df",
        function ()
            require("dapui").open()
            require("dap").continue()
        end,
        mode = "n",
        desc = "DAP continue",
    },
    {
        "<leader>dl",
        function()
            require("dap").set_log_level("TRACE")
        end,
        mode = "n",
        desc = "Set log level",
    },
    {
        "<leader>d-",
        function()
            require("dap").restart()
        end,
        mode = "n",
        desc = "Restart debugger",
    },
    {
        "<leader>d_",
        function()
            require("dap").terminate()
            require("dapui").close()
        end,
        mode = "n",
        desc = "Terminate debugger",
    },
    {
        "<leader>dc",
        function()
            require("dap").clear_breakpoints()
        end,
        mode = "n",
        desc = "Clear breakpoints",
    },
    {
        "<leader>dd",
        function()
            require("dapui").toggle()
        end,
        mode = "n",
        desc = "Toggle DAP UI"
    },
    {
        "[p",
        function()
            gotoBreakpoint("prev")
        end,
        mode = "n",
        desc = "Go to previous breakpoint",
    },
    {
        "]p",
        function()
            gotoBreakpoint("next")
        end,
        mode = "n",
        desc = "Go to next breakpoint",
    },
}
