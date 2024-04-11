local prefix = "plugins.opts.editing."
return {
    {
        "ku1ik/vim-pasta",
        keys = {
            { "p", "<Plug>AfterPasta", mode = "n", desc = "Paste after" },
            { "P", "<Plug>BeforePasta", mode = "n", desc = "Paste before" },
        },
    },
    {
        "inkarkat/vim-SpellCheck",
        dependencies = { "inkarkat/vim-ingo-library" },
        cmd = { "SpellCheck" },
    },
    {
        "tpope/vim-speeddating",
        keys = {
            { "<C-A>", "<Plug>SpeedDatingUp", mode = "n", desc = "Paste after" },
            { "<C-X>", "<Plug>SpeedDatingDown", mode = "n", desc = "Paste before" },
        },
    },
    {
        "psliwka/vim-dirtytalk",
        event = "InsertEnter",
        build = ":DirtytalkUpdate",
        init = function()
            vim.opt.spelllang = vim.opt.spelllang + { "programming" }
        end,
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
                tprevious = false,
                tnext = false,
            },
        },
    },
    {
        "glts/vim-radical",
        dependencies = { "glts/vim-magnum" },
        keys = {
            { "gA", "<Plug>RadicalView", desc = "View radical representations" },
            { "crb", "<Plug>RadicalCoerceToBinary", desc = "Coerce to binary" },
            { "cro", "<Plug>RadicalCoerceToOctal", desc = "Coerce to octal" },
            { "crx", "<Plug>RadicalCoerceToHex", desc = "Coerce to hex" },
            { "crd", "<Plug>RadicalCoerceToDecimal", desc = "Coerce to decimal" },
        }
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
        keys = {
            { "ds", "<Plug>(nvim-surround-delete)", mode = "n", desc = "Delete surrounding" },
            { "cs", "<Plug>(nvim-surround-change)", mode = "n", desc = "Change surrounding" },
            { "ys", "<Plug>(nvim-surround-normal)", mode = "n", desc = "Add surrounding" },
            { "yss", "<Plug>(nvim-surround-normal-cur)", mode = "n", desc = "Surround line" },
        },
        config = true,
    },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            filetypes = {
                c   = false,
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
        keys = {
            { "gb", mode = { "n", "x" }, desc = "Block comment selection" },
            { "gbc", mode = "n", desc = "Block comment selection" },
            { "gc", mode = { "n", "x" }, desc = "Comment selection" },
            { "gcc", mode = "n", desc = "Comment line" },
        },
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        keys = {{ "<leader>rn", ":IncRename ", mode = "n", desc = "Incremental rename" }},
        config = true,
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            { "<space>tj", function() require("treesj").join() end, mode = "n", desc = "Join trees" },
            { "<space>tm", function() require("treesj").toggle() end, mode = "n", desc = "Toggle trees" },
            { "<space>ts", function() require("treesj").split() end, mode = "n", desc = "Split trees" },
        },
        opts = { max_join_length = 240 },
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
        config = function()
            require("luasnip-latex-snippets").setup()
            local ls = require("luasnip")
            local dots = ls.parser.parse_snippet({ trig = "...", name = "Ellipses" }, "\\dots")
            dots.condition = require("luasnip-latex-snippets.util.utils").is_math()
            dots.priority = 101
            ls.add_snippets("tex", { dots }, { type = "autosnippets" })
        end,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "lervag/vimtex",
        },
    },
    {
        "andrewferrier/debugprint.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
            { "g?p", function() require("debugprint").debugprint() end, mode = "n", desc = "Debug print below" },
            { "g?P", function() require("debugprint").debugprint({ above = true }) end, mode = "v", desc = "Debug print above" },
            { "g?v", function() require("debugprint").debugprint({ variable = true }) end, mode = "n", desc = "Debug print variable" },
            { "g?V", function() require("debugprint").debugprint({ variable = true, above = true }) end, mode = "v", desc = "Debug print variable" },
            { "g?d", function() require("debugprint").deleteprints() end, mode = "n", desc = "Delete debug prints" },
        },
        config = true,
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "micangl/cmp-vimtex",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            return require(prefix .. "nvim-cmp")
        end,
    },
}
