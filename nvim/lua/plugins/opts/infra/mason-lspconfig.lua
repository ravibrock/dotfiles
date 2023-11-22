local foldsettings = { -- Needed for nvim-ufo to work properly
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

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
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = foldsettings
            require("lspconfig")[server].setup({ capabilities = capabilities })
        end,
        ["lua_ls"] = function()
            require("neodev").setup()
            require("lspconfig").lua_ls.setup({
                settings = { Lua = foldsettings },
            })
        end,
    },
})
