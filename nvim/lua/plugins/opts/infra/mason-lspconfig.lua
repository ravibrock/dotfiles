local foldsettings = { -- Needed for nvim-ufo to work properly
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local function on_attach(client, _)
    if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
    end
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
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = foldsettings
            require("lspconfig")[server].setup({ capabilities = capabilities })
            vim.cmd("LspStart") -- Workaround for language servers not starting automatically
        end,
        ["basedpyright"] = function()
            require("lspconfig").basedpyright.setup({
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
        ["ruff"] = function()
            require("lspconfig").ruff.setup({
                on_attach = on_attach,
            })
        end,
        ["pylsp"] = function()
            require("lspconfig").pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            autopep8    = { enabled = false },
                            pycodestyle = { enabled = false },
                            pyflakes    = { enabled = false },
                            yapf        = { enabled = false },
                        },
                    },
                },
            })
        end,
    },
})
