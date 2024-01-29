local foldsettings = { -- Needed for nvim-ufo to work properly
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "html",
        "jsonls",
        "ltex",
        "lua_ls",
        "marksman",
        "pyright",
        "ruff_lsp",
        "texlab",
        "vimls",
        "yamlls",
    },
    handlers = {
        function(server)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = foldsettings
            require("lspconfig")[server].setup({ capabilities = capabilities })
            vim.cmd("LspStart") -- Workaround for language servers not starting automatically
        end,
        ["ltex"] = function()
            require("lspconfig").ltex.setup({
                settings = {
                    ltex = {
                        language = "en-us",
                        disabledRules = {
                            ["en-us"] = {
                                "MORFOLOGIK_RULE_EN_US",
                                "UPPERCASE_SENTENCE_START",
                            },
                        },
                    },
                },
            })
        end,
        ["lua_ls"] = function()
            require("neodev").setup()
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            disable = { "trailing-space" },
                            globals = { "vim" },
                        },
                        unpack(foldsettings),
                    },
                },
            })
        end,
    },
})
