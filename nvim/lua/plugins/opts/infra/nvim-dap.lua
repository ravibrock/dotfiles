return {
    { "<leader>df", "<CMD>DapContinue<CR>", mode = "n", desc = "DAP continue" },
    { "<leader>dl", "<CMD>DapStepInto<CR>", mode = "n", desc = "DAP step into" },
    { "<leader>dj", "<CMD>DapStepOver<CR>", mode = "n", desc = "DAP step over" },
    { "<leader>dh", "<CMD>DapStepOut<CR>", mode = "n", desc = "DAP step out" },
    { "<leader>dl", function() require("dap").set_log_level("TRACE") end, mode = "n", desc = "Set log level" },
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
}
