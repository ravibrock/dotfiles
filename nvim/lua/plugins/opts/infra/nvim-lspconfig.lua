local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lsp_defaults.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)

lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
lspconfig.pyright.setup({})
lspconfig.sqlls.setup({})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = runtime_path },
            diagnostics = { globals = "vim" },
            telemetry = { enable = false },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false, },
        },
    },
})

lspconfig.cssls.setup({
    capabilities = capabilities,
})

lspconfig.html.setup({
    capabilities = capabilities,
})

lspconfig.jsonls.setup({
    capabilities = capabilities,
})

lspconfig.ltex.setup({
    language = "en-US",
})

lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                enable = false;
            },
        },
    },
})
