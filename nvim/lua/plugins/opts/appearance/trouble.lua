return {
    {
        "<leader>xd",
        function() require("trouble").toggle("document_diagnostics") end,
        mode = "n",
        desc = "Trouble document diagnostics",
    },
    {
        "<leader>xl",
        function() require("trouble").toggle("loclist") end,
        mode = "n",
        desc = "Trouble loclist",
    },
    {
        "<leader>xq",
        function() require("trouble").toggle("quickfix") end,
        mode = "n",
        desc = "Trouble quickfix",
    },
    {
        "<leader>xt",
        function() require("trouble").toggle("todo") end,
        desc = "Todo",
    },
    {
        "<leader>xw",
        function() require("trouble").toggle("workspace_diagnostics") end,
        mode = "n",
        desc = "Trouble workspace diagnostics",
    },
    {
        "<leader>xx",
        function() require("trouble").toggle() end,
        mode = "n",
        desc = "Toggle Trouble",
    },
}
