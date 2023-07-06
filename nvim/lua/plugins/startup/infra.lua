local prefix = "plugins.opts.infra."
return {
    {
        "farmergreg/vim-lastplace",
        "jghauser/mkdir.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        build = ":MasonUpdate",
        init = function()
            require(prefix .. "mason")
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            require(prefix .. "nvim-lspconfig")
        end,
    },
    {
        "stevearc/stickybuf.nvim",
        opts = {},
        setup = function()
            require("stickybuf").setup()
        end,
    },
    {
        "folke/neodev.nvim",
        event = "VeryLazy",
        opts = { experimental = { pathStrict = true } },
    },
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
        keys = {
            { "<leader>gb", "<cmd>Git blame<CR>", desc = "Blame current file" },
            { "<leader>gc", "<cmd>Git commit -a<CR>", desc = "Commit" },
            { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Diff" },
            { "<leader>gp", "<cmd>Git push<CR>", desc = "Push" },
            { "<leader>gl", "<cmd>Git pull<CR>", desc = "Pull" },
            { "<leader>gr", "<cmd>Git rebase -i HEAD~10<CR>", desc = "Rebase" },
            { "<leader>gs", "<cmd>Git<CR>", desc = "Status" },
        },
    },
    {
        "turbio/bracey.vim",
        ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        build = "npm install --prefix server",
        keys = {
            { "<leader>bb", "<cmd>Bracey<CR>" },
            { "<leader>br", "<cmd>BraceyReload<CR>" },
            { "<leader>bs", "<cmd>BraceyStop<CR>" },
        },
    },
    {
        "lervag/vimtex",
        ft = { "tex" },
        keys = {
            { "<leader>lc", "<cmd>VimtexClean<CR>"},
            { "<leader>ll", "<cmd>VimtexCompile<CR>" },
            { "<leader>lv", "<cmd>VimtexView<CR>"},
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
