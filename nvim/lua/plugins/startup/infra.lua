local prefix = "plugins.opts.infra."
return {
    {
        "farmergreg/vim-lastplace",
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
