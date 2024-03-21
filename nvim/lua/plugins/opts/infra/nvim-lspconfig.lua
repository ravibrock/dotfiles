local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lsp_defaults.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)

vim.keymap.set("n", "<leader>ef", vim.diagnostic.open_float, { desc = "Open float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>qq", vim.diagnostic.setloclist, { desc = "Set loclist" })

-- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", unpack(opts) })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", unpack(opts) })
        vim.keymap.set("n", "gp", require("actions-preview").code_actions, { desc = "Preview code actions" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", unpack(opts) })
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder", unpack(opts) })
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder", unpack(opts) })
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition", unpack(opts) })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", unpack(opts) })
    end,
    desc = "Create LSP keybinds",
})
