require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_uninstalled = " ",
            package_pending = "󱑤 ",
            package_installed = "󰄳 ",
        },
    },
})
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "vimls",
    },
})
