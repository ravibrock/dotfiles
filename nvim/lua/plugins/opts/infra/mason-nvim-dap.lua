require ("mason-nvim-dap").setup({
    ensure_installed = {
        "bash",
        "cppdbg",
        "python",
    },
    automatic_installation = true,
    handlers = {},
})
