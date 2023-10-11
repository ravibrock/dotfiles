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
        "hiphish/rainbow-delimiters.nvim",
        ft = { "racket" },
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
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
        build = ":TSUpdate",
        config = function()
            require(prefix .. "nvim-treesitter").setup()
        end,
    },
    {
        "luukvbaal/statuscol.nvim",
        dependencies = {
            "kevinhwang91/nvim-ufo",
            "lewis6991/gitsigns.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            local builtin = require("statuscol.builtin")
            local function newfold(args) return builtin.foldfunc(args):gsub(" ", "│") end
            require("statuscol").setup({
                ft_ignore = { "alpha" },
                clickmod = "c",
                relculright = true,
                segments = {
                    { sign = { name = { "Git" }, maxwidth = 1, colwidth = 2, auto = true }, click = "v:lua.ScSa" },
                    { sign = { name = { ".*"  }, maxwidth = 1, colwidth = 2, auto = true }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    { text = { newfold, " " }, maxwidth = 1, colwidth = 2, click = "v:lua.ScFa" },
                },
            })
        end,
    },
    {
        "folke/twilight.nvim",
        keys = {
            { "<leader>i", "<CMD>Twilight<CR>", desc = "Toggle Twilight", },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require(prefix .. "lualine").catppuccin()
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
            { "<leader>xt", "<CMD>TodoTrouble<CR>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<CMD>TodoTrouble keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<CMD>TodoTelescope<CR>", desc = "Todo" },
            { "<leader>sT", "<CMD>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme" },
        },
    },
    {
        "akinsho/bufferline.nvim",
        keys = {
            { "<leader>bp", "<CMD>BufferLineTogglePin<CR>", desc = "Toggle pin" },
            { "<leader>bP", "<CMD>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
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
        main = "ibl",
        opts = {
            exclude = {
                filetypes = {
                    "alpha",
                    "dashboard",
                    "help",
                    "lazy",
                    "mason",
                    "neo-tree",
                    "trouble",
                },
            },
            indent = { char = "│" },
            scope = {
                show_end = false,
                highlight = { "Function", "Label" },
            },
        },
    },
}
