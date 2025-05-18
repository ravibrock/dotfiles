---@diagnostic disable: undefined-field -- vim.uv causes undefined-field warnings
local patterns = { ".git", "lua", "requirements.txt", "Makefile" }
local uv = vim.uv

-- Get the root directory of the current project
---@param nearest? boolean: If true, return the nearest root directory else the closest to $HOME
local function get_root(nearest)
    local cwd = uv.cwd()
    local home = os.getenv("HOME")

    local function contains_any(dir)
        for _, pattern in ipairs(patterns) do
            local path = uv.fs_realpath(dir .. "/" .. pattern)
            if path then
                return true
            end
        end
        return false
    end

    local ret = nil
    local dir = cwd
    while dir ~= "/" do
        if dir == home then return ret or cwd end
        if contains_any(dir) then
            if nearest then return dir end
            ret = dir
        end
        dir = uv.fs_realpath(dir .. "/..")
    end
    return "/"
end

local function telescope_util(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = get_root(opts and opts.nearest) }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        require("telescope.builtin")[builtin](opts)
    end
end

local M = {}
M.keys = {
    -- navigation
    { "<leader>,", "<CMD>Telescope buffers show_all_buffers=true<CR>", desc = "Switch Buffer" },
    { "<leader>/", telescope_util("live_grep"), desc = "Grep (root dir)" },
    { "<leader>:", "<CMD>Telescope command_history<CR>", desc = "Command History" },
    { "<leader><space>", telescope_util("files"), desc = "Find files (root dir)" },
    -- find
    { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>ff", telescope_util("files", { nearest = true }), desc = "Find files (root dir)" },
    { "<leader>fg", "<CMD>Telescope git_files<CR>", desc = "Find files (git)" },
    { "<leader>fh", "<CMD>Telescope git_status<CR>", desc = "Git Status" },
    { "<leader>fF", telescope_util("files"), desc = "Find files (cwd)" },
    { "<leader>fr", "<CMD>Telescope oldfiles<CR>", desc = "Recent" },
    { "<leader>fR", telescope_util("oldfiles"), desc = "Recent (root)" },
    -- search
    { "<leader>sa", "<CMD>Telescope autocommands<CR>", desc = "Auto Commands" },
    { "<leader>sb", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
    { "<leader>sc", "<CMD>Telescope command_history<CR>", desc = "Command History" },
    { "<leader>sC", "<CMD>Telescope commands<CR>", desc = "Commands" },
    { "<leader>sd", "<CMD>Telescope diagnostics bufnr=0<CR>", desc = "Document diagnostics" },
    { "<leader>sD", "<CMD>Telescope diagnostics<CR>", desc = "Workspace diagnostics" },
    { "<leader>sg", telescope_util("live_grep", { nearest = true }), desc = "Grep (cwd)" },
    { "<leader>sG", telescope_util("live_grep"), desc = "Grep (root dir)" },
    { "<leader>sh", "<CMD>Telescope help_tags<CR>", desc = "Help Pages" },
    { "<leader>sH", "<CMD>Telescope highlights<CR>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<CMD>Telescope keymaps<CR>", desc = "Key Maps" },
    { "<leader>sM", "<CMD>Telescope man_pages<CR>", desc = "Man Pages" },
    { "<leader>sm", "<CMD>Telescope marks<CR>", desc = "Jump to Mark" },
    { "<leader>so", "<CMD>Telescope vim_options<CR>", desc = "Options" },
    { "<leader>sR", "<CMD>Telescope resume<CR>", desc = "Resume" },
    { "<leader>sw", telescope_util("grep_string", { nearest = true }), desc = "Word (cwd)" },
    { "<leader>sW", telescope_util("grep_string"), desc = "Word (root)" },
    -- misc
    { "<leader>u", function() require("telescope").extensions.undo.undo() end, desc = "Undo tree" },
    { "<leader>bx", function() require("telescope").extensions.bibtex.bibtex() end, desc = "BibTeX" },
    {
        "<leader>ss",
        telescope_util("lsp_document_symbols", {
            symbols = {
                "Class",
                "Function",
                "Method",
                "Constructor",
                "Interface",
                "Module",
                "Struct",
                "Trait",
                "Field",
                "Property",
            },
        }),
        desc = "Go to Symbol",
    },
    {
        "<leader>sS",
        telescope_util("lsp_dynamic_workspace_symbols", {
            symbols = {
                "Class",
                "Function",
                "Method",
                "Constructor",
                "Interface",
                "Module",
                "Struct",
                "Trait",
                "Field",
                "Property",
            },
        }),
        desc = "Go to Symbol (Workspace)",
    },
}

M.opts = {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- Comment out these mappings if Telescope is erroring on load
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-n>"] = "preview_scrolling_down",
                ["<C-p>"] = "preview_scrolling_up",
                ["<C-t>"] = require("trouble.sources.telescope").open,
                ["<esc>"] = "close",
            },
        },
    },
    extensions = {
        ascii = {},
        bibtex = { context = true, context_fallback = true },
        fzf = {},
        nerdy = {},
        persisted = {},
        undo = {},
    },
}

vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
    end,
    desc = "Prevent entering buffers in insert mode",
})

return M
