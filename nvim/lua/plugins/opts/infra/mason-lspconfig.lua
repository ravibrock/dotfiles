local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = { -- Needed for nvim-ufo to work properly
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    return capabilities
end

require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright",
        "bashls",
        "clangd",
        "cssls",
        "html",
        "jsonls",
        "ltex",
        "lua_ls",
        "marksman",
        "ruff",
        "vimls",
        "yamlls",
    },
    handlers = {
        function(server)
            require("lspconfig")[server].setup({ capabilities = get_capabilities() })
        end,
        ["basedpyright"] = function()
            require("lspconfig").basedpyright.setup({
                capabilities = get_capabilities(),
                settings = {
                    basedpyright = {
                        disableOrganizeImports = true,
                        typeCheckingMode = "off",
                    },
                },
            })
        end,
        ["ltex"] = function()
            require("lspconfig").ltex.setup({
                capabilities = get_capabilities(),
                settings = {
                    ltex = {
                        language = "en-us",
                        disabledRules = {
                            ["en-us"] = {
                                "EN_UNPAIRED_BRACKETS",
                                "MAC_OS",
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
                capabilities = get_capabilities(),
                settings = {
                    Lua = {
                        diagnostics = {
                            disable = { "trailing-space" },
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
        ["ruff"] = function()
            require("lspconfig").ruff.setup({
                capabilities = get_capabilities(),
                on_attach = function(client, _)
                    client.server_capabilities.hoverProvider = false
                end,
            })
        end,
    },
})
