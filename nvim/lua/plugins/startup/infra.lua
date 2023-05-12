local prefix = "plugins.opts.infra."
return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require(prefix .. "nvim-lspconfig")
        end,
    },
    {
        "folke/neodev.nvim",
        opts = { experimental = { pathStrict = true } }
    },
    {
        "turbio/bracey.vim",
        ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        build = "npm install --prefix server",
        keys = {
            { "<leader>bb", "<cmd>Bracey<CR>" },
        },
    },
    {
        "lervag/vimtex",
        ft = { "tex" },
        keys = { { "<leader>ll", "<cmd>VimtexCompile<CR>" } },
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
    {
        "farmergreg/vim-lastplace",
    },
}
