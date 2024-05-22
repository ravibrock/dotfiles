---@diagnostic disable: missing-parameter
return {
    {
        "g?p",
        function() require("debugprint").debugprint() end,
        mode = "n",
        desc = "Debug print below",
    },
    {
        "g?P",
        function() require("debugprint").debugprint({ above = true }) end,
        mode = "v",
        desc = "Debug print above",
    },
    {
        "g?v",
        function() require("debugprint").debugprint({ variable = true }) end,
        mode = "n",
        desc = "Debug print variable",
    },
    {
        "g?V",
        function() require("debugprint").debugprint({ variable = true, above = true }) end,
        mode = "v",
        desc = "Debug print variable",
    },
    {
        "g?d",
        function() require("debugprint").deleteprints() end,
        mode = "n",
        desc = "Delete debug prints",
    },
}
