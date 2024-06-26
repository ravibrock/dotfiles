require ("mason-nvim-dap").setup({
    ensure_installed = {
        "bash",
        "cppdbg",
        "delve",
        "python",
    },
    automatic_installation = true,
    handlers = {},
})
