local function nf() return "" end

local function setup(colorscheme)
    require("lualine").setup({
        options = {
            icons_enabled = true,
            theme = colorscheme,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = {{ "mode", fmt = function(str) return str:sub(1,1) end }},
            lualine_b = {
                "branch",
                { nf, cond = function() return vim.fn.finddir(".git", vim.fn.getcwd() .. ";") == "" end },
                "diff",
                "diagnostics",
            },
            lualine_c = { "filename" },
            lualine_x = { "encoding" },
            lualine_y = { "searchcount", "progress" },
            lualine_z = { "%l/%L" },
        },
        inactive_sections = {
            lualine_a = { "filename" },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = { "encoding" },
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    })
end

local theme = {}
theme.catppuccin = function()
    local colors = require("catppuccin.palettes").get_palette()

    local colorscheme = {
        visual = {
            --- @diagnostic disable: need-check-nil
            a = { fg = colors.base, bg = colors.flamingo, gui = "bold" },
            b = { fg = colors.text, bg = colors.surface0 },
            c = { fg = colors.surface0, bg = colors.subtext0 },
        },
        replace = {
            a = { fg = colors.base, bg = colors.red, gui = "bold" },
            b = { fg = colors.text, bg = colors.surface0 },
            c = { fg = colors.surface0, bg = colors.subtext0 },
        },
        command = {
            a = { fg = colors.base, bg = colors.blue, gui = "bold" },
            b = { fg = colors.base, bg = colors.blue },
            c = { fg = colors.base, bg = colors.blue },
        },
        inactive = {
            a = { fg = colors.surface0, bg = colors.subtext0, gui = "bold" },
            b = { fg = colors.surface0, bg = colors.subtext0 },
            c = { fg = colors.surface0, bg = colors.subtext0 },
        },
        normal = {
            a = { fg = colors.base, bg = colors.blue, gui = "bold" },
            b = { fg = colors.text, bg = colors.surface0 },
            c = { fg = colors.surface0, bg = colors.subtext0 },
        },
        insert = {
            a = { fg = colors.base, bg = colors.mauve, gui = "bold" },
            b = { fg = colors.text, bg = colors.surface0 },
            c = { fg = colors.surface0, bg = colors.subtext0 },
        },
        --- @diagnostic enable: need-check-nil
    }

    setup(colorscheme)
end

return theme
