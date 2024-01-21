local prefix = "plugins.opts.editing."
return {
    {
        "tpope/vim-speeddating",
        event = "VeryLazy",
    },
    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = true,
    },
    {
        "gbprod/substitute.nvim",
        opts = {
            highlight_substituted_text = { enabled = false },
        },
        keys = {
            { "gr", function() require("substitute").operator() end, mode = "n", desc = "Replace operator" },
            { "gR", function() require("substitute").eol() end, mode = "n", desc = "Replace until EOL" },
            { "grr", function() require("substitute").line() end, mode = "n", desc = "Replace line" },
            { "gr", function() require("substitute").visual() end, mode = "x", desc = "Replace selection" },
            { "gs", function() require("substitute.exchange").operator() end, mode = "n", desc = "Exchange operator" },
            { "gss", function() require("substitute.exchange").line() end, mode = "n", desc = "Exchange line" },
            { "gs", function() require("substitute.exchange").visual() end, mode = "x", desc = "Exchange selection" },
            { "<ESC>", function() require("substitute.exchange").cancel() end, mode = "n", desc = "Cancel exchange" },
        },
    },
    {
        "tummetott/unimpaired.nvim",
        event = "VeryLazy",
        opts = {
            keymaps = {
                bprevious = false,
                bnext = false,
                bfirst = false,
            },
        },
    },
    {
        "glts/vim-radical",
        event = "VeryLazy",
        dependencies = { "glts/vim-magnum" },
    },
    {
        "guns/vim-sexp",
        ft = { "racket" },
    },
    {
        "ku1ik/vim-pasta",
        event = "VeryLazy",
    },
    {
        "godlygeek/tabular",
        cmd = { "Tab", "Tabularize" },
        keys = {
            { "<leader>t=", "<CMD>Tabularize /=<CR>", mode = { "n", "v" },  desc = "Tabularize on `=`" },
            { "<leader>t:", "<CMD>Tabularize /:<CR>", mode = { "n", "v" }, desc = "Tabularize on `:`" },
            { "<leader>tt", ":Tabularize /", mode = { "n", "v" },  desc = "Initiate tabularize" },
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
        opts = {
            filetypes = {
                racket = false,
                tex = false,
            },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        config = true,
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = "Spectre",
        keys = {
            { "<leader>fs", function() require("spectre").toggle() end, mode = "n", desc = "Toggle Spectre" },
            { "<leader>fv", function() require("spectre").open_visual({ select_word = true }) end, mode = "n", desc = "[Spectre] Search current word" },
            { "<leader>fw", function() require("spectre").open_visual() end, mode = "v", desc = "[Spectre] Search current word" },
            { "<leader>fp", function() require("spectre").open_file_search({ select_word = true }) end, mode = "n", desc = "[Spectre] Search on current file" },
        },
        build = [[
            mkdir -p spectre_oxi/.cargo
            printf "[build]\nrustflags = [\n  '-C', 'link-arg=-undefined',\n  '-C', 'link-arg=dynamic_lookup',\n]" > spectre_oxi/.cargo/config
            ./build.sh nvim-oxi
            rm -rf .cargo
        ]],
        opts = {
            default = {
                replace = { cmd = "oxi" },
            },
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
        opts = {
            disable_filetype = { "racket" },
        },
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
        ft = "tex",
        config = true,
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
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "micangl/cmp-vimtex",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            return require(prefix .. "nvim-cmp")
        end,
    },
}
