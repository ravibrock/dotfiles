local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = { -- Needed for nvim-ufo to work properly
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    return capabilities
end
local function navic(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
end

require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright",
        "bashls",
        "clangd",
        "cssls",
        "gopls",
        "html",
        "jdtls",
        "jsonls",
        "ltex",
        "lua_ls",
        "marksman",
        "ruff",
        "vtsls",
        "vimls",
        "yamlls",
    }
})

local lsp_configs = {
    ["*"] = {
        capabilities = get_capabilities(),
        on_attach = navic,
    },
    basedpyright = {
        capabilities = get_capabilities(),
        on_attach = function(client, bufnr)
            navic(client, bufnr)
            local function filter(arr, func)
                local new_index = 1
                local size_orig = #arr
                for old_index, v in ipairs(arr) do
                    if func(v, old_index) then
                        arr[new_index] = v
                        new_index = new_index + 1
                    end
                end
                for i = new_index, size_orig do arr[i] = nil end
            end

            local function pyright_accessed_filter(diagnostic)
                if string.match(diagnostic.message, '".+" is not accessed') then return false end
                return true
            end

            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                function(a, params, client_id, c, config)
                    filter(params.diagnostics, pyright_accessed_filter)
                    vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
                end,
                {}
            )
        end,
        settings = {
            basedpyright = {
                disableOrganizeImports = true,
                typeCheckingMode = "off",
            },
        },
    },
    ltex = {
        capabilities = get_capabilities(),
        on_attach = navic,
        settings = {
            ltex = {
                language = "en-US",
                disabledRules = {
                    ["en-US"] = {
                        "COMMA_PARENTHESIS_WHITESPACE",
                        "EN_UNPAIRED_BRACKETS",
                        "MAC_OS",
                        "MORFOLOGIK_RULE_EN_US",
                        "SENTENCE_WHITESPACE",
                        "UPPERCASE_SENTENCE_START",
                    },
                },
            },
        },
    },
    lua_ls = {
        capabilities = get_capabilities(),
        on_attach = navic,
        settings = {
            Lua = {
                diagnostics = {
                    disable = { "trailing-space" },
                    globals = { "vim" },
                },
            },
        },
    },
    ruff = {
        capabilities = get_capabilities(),
        on_attach = function(client, bufnr)
            navic(client, bufnr)
            client.server_capabilities.hoverProvider = false
        end,
        init_options = {
            settings = {
                lint = {
                    ignore = { "E741" },
                }
            }
        }
    },
}

for lsp, config in pairs(lsp_configs) do
    vim.lsp.config(lsp, config)
end
