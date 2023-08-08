local prefix = "plugins.opts.appearance."
return {
    {
        "folke/trouble.nvim",
        "echasnovski/mini.bufremove",
    },
    {
        "MaximilianLloyd/ascii.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "│" },
                    change       = { text = "│" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()
            require(prefix .. "nvim-treesitter").setup()
        end,
    },
    {
        "folke/twilight.nvim",
        keys = {
            { "<leader>i", "<cmd>Twilight<cr>", desc = "Toggle Twilight", },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require(prefix .. "lualine").setup()
        end,
    },
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                flavour = "mocha",
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
        },
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        },
        config = function()
            require(prefix .. "bufferline").setup()
        end,
    },
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            return require(prefix .. "alpha-nvim").opts()
        end,
        config = function(_, dashboard)
            require(prefix .. "alpha-nvim").config(_, dashboard)
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            char = "│",
            filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
                space_char_blankline = " ",
            }
        end,
    },
}
