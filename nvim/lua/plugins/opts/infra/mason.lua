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

require('mason-tool-installer').setup({
  ensure_installed = {
        "bash-language-server",
        "clangd",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "pyright",
        "rust-analyzer",
        "shellcheck",
        "vim-language-server",
  },
  auto_update = true,
})
