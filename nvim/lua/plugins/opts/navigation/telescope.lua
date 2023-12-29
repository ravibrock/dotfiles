local root_patterns = { ".git", "lua" }

local function get_root()
    local path = vim.api.nvim_buf_get_name(0)
    ---@diagnostic disable-next-line: cast-local-type
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace and vim.tbl_map(function(ws)
                return vim.uri_to_fname(ws.uri)
            end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                ---@diagnostic disable-next-line: param-type-mismatch
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    local root = roots[1]
    if not root then
        ---@diagnostic disable-next-line: cast-local-type
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    return root
end

local function telescope_util(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = get_root() }, opts or {})
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
    { "<leader>ff", telescope_util("files"), desc = "Find files (root dir)" },
    { "<leader>fF", telescope_util("files", { cwd = false }), desc = "Find files (cwd)" },
    { "<leader>fr", "<CMD>Telescope oldfiles<CR>", desc = "Recent" },
    { "<leader>fR", telescope_util("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
    -- search
    { "<leader>sa", "<CMD>Telescope autocommands<CR>", desc = "Auto Commands" },
    { "<leader>sb", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
    { "<leader>sc", "<CMD>Telescope command_history<CR>", desc = "Command History" },
    { "<leader>sC", "<CMD>Telescope commands<CR>", desc = "Commands" },
    { "<leader>sd", "<CMD>Telescope diagnostics bufnr=0<CR>", desc = "Document diagnostics" },
    { "<leader>sD", "<CMD>Telescope diagnostics<CR>", desc = "Workspace diagnostics" },
    { "<leader>sg", telescope_util("live_grep"), desc = "Grep (root dir)" },
    { "<leader>sG", telescope_util("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>sh", "<CMD>Telescope help_tags<CR>", desc = "Help Pages" },
    { "<leader>sH", "<CMD>Telescope highlights<CR>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<CMD>Telescope keymaps<CR>", desc = "Key Maps" },
    { "<leader>sM", "<CMD>Telescope man_pages<CR>", desc = "Man Pages" },
    { "<leader>sm", "<CMD>Telescope marks<CR>", desc = "Jump to Mark" },
    { "<leader>so", "<CMD>Telescope vim_options<CR>", desc = "Options" },
    { "<leader>sR", "<CMD>Telescope resume<CR>", desc = "Resume" },
    { "<leader>sw", telescope_util("grep_string"), desc = "Word (root dir)" },
    { "<leader>sW", telescope_util("grep_string", { cwd = false }), desc = "Word (cwd)" },
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
                ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
                ["<esc>"] = "close",
            },
        },
    },
    extensions = {
        bibtex = { context = true, context_fallback = true },
        fzf = {},
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
