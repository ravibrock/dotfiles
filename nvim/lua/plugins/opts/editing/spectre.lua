return {
    {
        "<leader>fs",
        function() require("spectre").toggle() end,
        mode = "n",
        desc = "Toggle Spectre",
    },
    {
        "<leader>fv",
        function() require("spectre").open_visual({ select_word = true }) end,
        mode = "n",
        desc = "[Spectre] Search current word",
    },
    {
        "<leader>fw",
        function() require("spectre").open_visual() end,
        mode = "v",
        desc = "[Spectre] Search current word",
    },
    {
        "<leader>fp",
        function() require("spectre").open_file_search({ select_word = true }) end,
        mode = "n",
        desc = "[Spectre] Search on current file",
    },
}
