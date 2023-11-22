local prefix = "plugins.opts.navigation."
return {
    {
        "andymass/vim-matchup",
        event = "VeryLazy",
    },
    {
        "ggandor/leap.nvim",
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
            { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
        },
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    {
        "ggandor/flit.nvim",
        keys = {
            { "f", mode = { "n", "x", "o" }, desc = "Flit forward to" },
            { "F", mode = { "n", "x", "o" }, desc = "Flit backward to" },
        },
        config = true,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>o",
                function()
                    require("neo-tree.command").execute({ toggle = true })
                end,
                desc = "Toggle NeoTree explorer",
            },
        },
        init = function()
            if vim.fn.argc(-1) == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = function()
            return require(prefix .. "neo-tree")
        end,
    },
    {
       "nvim-telescope/telescope.nvim",
        dependencies = {
            "debugloop/telescope-undo.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-bibtex.nvim",
        },
        cmd = "Telescope",
        version = false,
        keys = function()
            return require(prefix .. "telescope").keys
        end,
        opts = function()
            -- Comment out mappings on lines 125-134 of the Telescope config if it's erroring
            return require(prefix .. "telescope").opts
        end,
    },
    {
        "stevearc/aerial.nvim",
        opts = { filter_kind = false },
        cmd = { "AerialToggle" },
        keys = {{ "<leader>a", "<CMD>AerialToggle<CR>", desc = "Aerial" }},
        config = function()
            require("aerial").setup({ backends = { "lsp", "treesitter" } })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
}
