local prefix = "plugins.opts.navigation."
return {
    {
        "andymass/vim-matchup",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "chrisgrieser/nvim-spider",
        opts = {
            customPatterns = { "%$*%w+" },
        },
        keys = {
            { "b", mode = { "n", "o", "v", "x" }, function() require("spider").motion("b") end, desc = "Spider: b" },
            { "e", mode = { "n", "o", "v", "x" }, function() require("spider").motion("e") end, desc = "Spider: e" },
            { "w", mode = { "n", "o", "v", "x" }, function() require("spider").motion("w") end, desc = "Spider: w" },
        },
    },
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "ggandor/leap.nvim",
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
        },
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    {
        "echasnovski/mini.jump",
        opts = { delay = { highlight = 0 } },
        keys = {
            { "f", mode = { "n", "x", "o" }, desc = "Forward search" },
            { "F", mode = { "n", "x", "o" }, desc = "Backward search" },
        },
        init = function()
            vim.cmd("highlight MiniJump guifg=#a6e3a1 gui=underline")
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
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
            "nvim-telescope/telescope-fzf-native.nvim",
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
        "nacro90/numb.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "stevearc/aerial.nvim",
        cmd = { "AerialToggle" },
        keys = {{ "<leader>a", "<CMD>AerialToggle<CR>", desc = "Aerial" }},
        opts = {
            filter_kind = false,
            backends = { "lsp", "treesitter", "markdown", "man" },
            layout = { min_width = 30 },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
}
