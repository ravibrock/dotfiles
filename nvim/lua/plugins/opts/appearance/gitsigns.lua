return {
    {
        "[h",
        function()
            require("gitsigns").nav_hunk("prev")
            require("gitsigns").preview_hunk()
        end,
        mode = "n",
        desc = "Previous hunk",
    },
    {
        "]h",
        function()
            require("gitsigns").nav_hunk("next")
            require("gitsigns").preview_hunk()
        end,
        mode = "n",
        desc = "Next hunk",
    },
    {
        "<leader>hh",
        function() require("gitsigns").preview_hunk() end,
        mode = "n",
        desc = "Preview hunk",
    },
    {
        "<leader>hr",
        function() require("gitsigns").reset_hunk() end,
        mode = "n",
        desc = "Reset hunk",
    },
    {
        "<leader>hR",
        function() require("gitsigns").reset_buffer() end,
        mode = "n",
        desc = "Reset buffer",
    },
    {
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        mode = { "o", "x" },
        desc = "Select within hunk",
    }
}
