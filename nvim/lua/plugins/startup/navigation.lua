local prefix = "plugins.opts.navigation."
return {
    {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
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
        config = function()
            require("flit").setup()
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
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
                desc = "Explorer NeoTree",
            },
        },
        opts = function()
            return require(prefix .. "neo-tree")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false,
        keys = function()
            return require(prefix .. "telescope").keys
        end,
        opts = function()
            return require(prefix .. "telescope").opts
        end,
    },
    {
        "stevearc/aerial.nvim",
        opts = { filter_kind = false },
        keys = {{ "<leader>t", "<cmd>AerialToggle<cr>zM", desc = "Aerial" }},
        setup = function()
            require("aerial").setup({backends = { "lsp", "treesitter" }})
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
}
