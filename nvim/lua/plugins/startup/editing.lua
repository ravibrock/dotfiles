local prefix = "plugins.opts.editing."
return {
    {
        -- "micangl/cmp-vimtex", Seems very buggy, maybe enable in future
        "tpope/vim-repeat",
        "tpope/vim-speeddating",
        "vim-scripts/ReplaceWithRegister",
    },
    {
        "tummetott/unimpaired.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "glts/vim-radical",
        dependencies = { "glts/vim-magnum" },
    },
    {
        "guns/vim-sexp",
        ft = { "racket" },
    },
    {
        "ku1ik/vim-pasta",
        config = function()
            vim.g.pasta_enabled_filetypes = { "markdown", "python", "yaml" }
        end,
    },
    {
        "godlygeek/tabular",
        cmd = { "Tab", "Tabularize" },
        keys = {
            { "<leader>t=", "<CMD>Tabularize /=<CR>", mode = { "n", "v" },  desc = "Tabularize on `=`"},
            { "<leader>t:", "<CMD>Tabularize /:<CR>", mode = { "n", "v" }, desc = "Tabularize on `:`"},
            { "<leader>tt", ":Tabularize /", mode = { "n", "v" },  desc = "Initiate tabularize"},
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true,
    },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        build = ":Copilot auth",
        config = function()
            require("copilot").setup({
                filetypes = {
                    racket = false,
                    tex = false,
                },
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        config = true,
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = "nvim-lua/plenary.nvim",
        command = "Spectre",
        keys = {
            { "<leader>ft", function() require("spectre").toggle() end, mode = "n", desc = "Toggle Spectre" },
            { "<leader>fv", function() require("spectre").open_visual({ select_word = true }) end, mode = "n", desc = "Search current word" },
            { "<leader>fw", function() require("spectre").open_visual() end, mode = "v", desc = "Search current word" },
            { "<leader>fp", function() require("spectre").open_file_search({ select_word = true }) end, mode = "n", desc = "Search on current file" },
        },
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({ disable_filetype = { "racket" } })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        build = "make install_jsregexp",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip").config.setup({ enable_autosnippets = true })
            vim.keymap.set({ "i", "s" }, "<C-I>", function() require("luasnip").jump(1) end, { silent = true, desc = "Jump forward" })
            vim.keymap.set({ "i", "s" }, "<C-U>", function() require("luasnip").jump(-1) end, { silent = true, desc = "Jump backward" })
        end,
    },
    {
        "iurimateus/luasnip-latex-snippets.nvim",
        ft = { "tex" },
        config = function()
            require("luasnip-latex-snippets").setup()
        end,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "lervag/vimtex",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            return require(prefix .. "nvim-cmp")
        end,
    },
}
