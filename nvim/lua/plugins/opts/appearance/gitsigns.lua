local function preview_hunk() -- Workaround for previews not working properly
    local gid = vim.api.nvim_create_augroup("GitsignsPreviewOnMove", { clear = true })

    if require("gitsigns.popup").is_open("hunk") ~= nil then
        require("gitsigns.popup").close("hunk")
    end

    vim.api.nvim_create_autocmd("CursorMoved", {
        group = gid,
        callback = function()
            require("gitsigns").preview_hunk()
            vim.api.nvim_clear_autocmds({ group = "GitsignsPreviewOnMove" })
        end,
    })
end

local function on_hunk()
    local linenr = vim.fn.line(".")
    local colnr = vim.fn.col(".")
    local first_char = vim.fn.getline(linenr):find("%S") or 1
    if colnr ~= first_char then
        return false
    end
    for _, hunk in ipairs(require("gitsigns").get_hunks()) do
        if hunk.removed.start == linenr or hunk.added.start == linenr then
            return true
        end
    end
    return false
end

local function nav_hunk(dir)
    if #require("gitsigns").get_hunks() == 1 and on_hunk() then
        if not require("gitsigns.popup").is_open("hunk") then
            require("gitsigns").preview_hunk()
        end
    else
        preview_hunk()
        require("gitsigns").nav_hunk(dir)
    end
end

return {
    {
        "[h",
        function() nav_hunk("prev") end,
        mode = "n",
        desc = "Previous hunk",
    },
    {
        "]h",
        function() nav_hunk("next") end,
        mode = "n",
        desc = "Next hunk",
    },
    {
        "<leader>hh",
        function() require("gitsigns").preview_hunk() end,
        mode = "n",
        desc = "Preview hunk",
    },
    {
        "<leader>hr",
        function() require("gitsigns").reset_hunk() end,
        mode = "n",
        desc = "Reset hunk",
    },
    {
        "<leader>hR",
        function() require("gitsigns").reset_buffer() end,
        mode = "n",
        desc = "Reset buffer",
    },
    {
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        mode = { "o", "x" },
        desc = "Select within hunk",
    },
    {
        "<leader>gh",
        function() require("gitsigns").stage_hunk() end,
        mode = "n",
        desc = "Stage hunk",
    },
    {
        "<leader>gh",
        function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
        mode = "v",
        desc = "Stage hunk",
    },
    {
        "<leader>gr",
        function() require("gitsigns").undo_stage_hunk() end,
        mode = "n",
        desc = "Undo stage hunk",
    },
}
