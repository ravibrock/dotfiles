local prefix = "plugins.opts.navigation."
return {
    {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
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
        opts = function ()
            return require(prefix .. "neo-tree")
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        keys = function ()
            return require(prefix .. "telescope").keys
        end,
        opts = function ()
            return require(prefix .. "telescope").opts
        end
    },
    {
        'stevearc/aerial.nvim',
        opts = {},
        keys = { { "<leader>t", "<cmd>AerialToggle<cr>", desc = "Aerial" } },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    }
}
