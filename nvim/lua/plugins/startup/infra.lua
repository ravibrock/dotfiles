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
    }
}
