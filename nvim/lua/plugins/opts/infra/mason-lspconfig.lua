require("mason-lspconfig").setup({
    ensure_installed = {
        "asm_lsp",
        "bashls",
        "clangd",
        "cssls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "r_language_server",
        "rust_analyzer",
        "texlab",
        "tsserver",
        "vimls",
        "yamlls",
    },
    handlers = {
        function(server)
            require("lspconfig")[server].setup({ capabilities = vim.lsp.protocol.make_client_capabilities() })
        end,
        ["lua_ls"] = function()
            require("neodev").setup()
        end,
    },
})
