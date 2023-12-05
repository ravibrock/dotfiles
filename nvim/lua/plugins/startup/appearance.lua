local prefix = "plugins.opts.appearance."
return {
    {
        "xiyaowong/nvim-cursorword",
        event = "VeryLazy",
    },
    {
        "ellisonleao/carbon-now.nvim",
        cmd = "CarbonNow",
        opts = {
            open_cmd = "open",
            options = {
                titlebar = "Ravi Brock - @ravibrock",
                theme = "dracula pro",
            },
        },
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
        version = false,
        config = function()
            require(prefix .. "nvim-treesitter").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {},
    },
    {
        "luukvbaal/statuscol.nvim",
        event = { "BufReadPost", "BufNewFile" },
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
                    { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 2, auto = true }, click = "v:lua.ScSa" },
                    { sign = { name = { ".*"  }, maxwidth = 1, colwidth = 2, auto = true }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    { text = { newfold, " " }, maxwidth = 1, colwidth = 2, click = "v:lua.ScFa" },
                },
            })
        end,
    },
    {
        "folke/twilight.nvim",
        keys = {{ "<leader>i", "<CMD>Twilight<CR>", desc = "Toggle Twilight" }},
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline and ruler until lualine loads
                vim.o.statusline = " "
                vim.o.ruler = false
            else
                -- hide the statusline and ruler on the starter page
                vim.o.laststatus = 0
                vim.o.ruler = false
            end
        end,
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
                integrations = {
                    aerial = true,
                    barbar = true,
                    which_key = true,
                },
            })
        end,
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        event = "WinNew",
        config = true,
    },
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, mode = "n", desc = "Trouble document diagnostics" },
            { "<leader>xl", function() require("trouble").toggle("loclist") end, mode = "n", desc = "Trouble loclist" },
            { "<leader>xq", function() require("trouble").toggle("quickfix") end, mode = "n", desc = "Trouble quickfix" },
            { "<leader>xt", function() require("trouble").toggle("todo") end, desc = "Todo" },
            { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, mode = "n", desc = "Trouble workspace diagnostics" },
            { "<leader>xx", function() require("trouble").toggle() end, mode = "n", desc = "Toggle Trouble" },
        },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, mode = "n", desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, mode = "n", desc = "Previous todo comment" },
            { "<leader>st", "<CMD>TodoTelescope<CR>", mode = "n", desc = "Todo Telescope" },
        },
    },
    {
        "romgrk/barbar.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            animation = false,
            auto_hide  = 1,
            icons = {
                pinned = { button = '' },
            },
        },
        version = '^1.0.0',
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
