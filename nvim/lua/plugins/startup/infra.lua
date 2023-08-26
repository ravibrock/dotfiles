local prefix = "plugins.opts.infra."
return {
    {
        "farmergreg/vim-lastplace",
        "jghauser/mkdir.nvim",
    },
    {
        "lambdalisue/suda.vim",
        cmd = { "SudaWrite", "SudaRead" },
    },
    {
        "lewis6991/hover.nvim",
        init = function()
            require("hover.providers.lsp")
            require("hover.providers.gh")
            require("hover.providers.gh_user")
            require("hover.providers.jira")
            require("hover.providers.man")
            require("hover.providers.dictionary")
        end,
        config = function()
            require("hover").setup({
                preview_opts = { border = "rounded" },
                preview_window = false,
                title = true,
            })
        end,
        keys = {
            {
                "K",
                function()
                    require("hover").hover()
                end,
                desc = "Hover",
            },
            {
                "gK",
                function()
                    require("hover").hover_select()
                end,
                desc = "Hover (select)",
            },
        },
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        build = ":MasonUpdate",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            require(prefix .. "mason")
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = "VeryLazy",
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            "williamboman/mason.nvim",
        },
        config = function()
            require(prefix .. "null-ls")
        end,
        init = function()
            require(prefix .. "mason-null-ls")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            require(prefix .. "nvim-lspconfig")
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        config = function()
            require(prefix .. "null-ls")
        end,
    },
    {
        "stevearc/stickybuf.nvim",
        opts = {},
        init = function()
            require("stickybuf").setup()
        end,
    },
    {
        "folke/neodev.nvim",
        opts = { experimental = { pathStrict = true } },
    },
    {
        "tpope/vim-fugitive",
        dependencies = { "tpope/vim-rhubarb" },
        cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
        keys = {
            { "<leader>gb", "<CMD>Git blame<CR>", desc = "Blame current file" },
            { "<leader>gc", "<CMD>Git commit -a <BAR> startinsert<CR>", desc = "Commit" },
            { "<leader>gd", "<CMD>Gdiffsplit<CR>", desc = "Diff" },
            { "<leader>gp", "<CMD>Git push<CR>", desc = "Push" },
            { "<leader>gl", "<CMD>Git pull<CR>", desc = "Pull" },
            { "<leader>gr", "<CMD>Git rebase -i --root<CR>", desc = "Rebase" },
            { "<leader>gs", "<CMD>Git<CR>", desc = "Status" },
        },
    },
    {
        "turbio/bracey.vim",
        ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        build = "npm install --prefix server",
        keys = {
            { "<leader>bb", "<CMD>Bracey<CR>" },
            { "<leader>br", "<CMD>BraceyReload<CR>" },
            { "<leader>bs", "<CMD>BraceyStop<CR>" },
        },
    },
    {
        "lervag/vimtex",
        ft = { "tex" },
        keys = {
            { "<leader>lc", "<CMD>VimtexClean<CR>"},
            { "<leader>ll", "<CMD>VimtexCompile<CR>" },
            { "<leader>lv", "<CMD>VimtexView<CR>"},
        },
        init = function()
            vim.g.vimtex_view_method = "sioyek"
            vim.g.tex_conceal = "abdmg"
            vim.opt.conceallevel = 2
        end,
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
    },
}
