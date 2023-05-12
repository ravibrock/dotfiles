local function theme()
    local colors = {
        black      = '#0e1117',
        blue       = '#366adc',
        cyan       = '#b6d4f8',
        gray       = '#2f3030',
        green      = '98e491',
        light_gray = '#89989b',
        magenta    = 'caaaf9',
        red        = '#ee8277',
        white      = 'e4eaef',
        yellow     = '#d29f67',
    }

    return {
        visual = {
            a = { fg = colors.gray, bg = colors.green, gui = 'bold' },
            b = { fg = colors.white, bg = colors.gray },
            c = { fg = colors.black, bg = colors.light_gray },
        },
        replace = {
            a = { fg = colors.gray, bg = colors.red, gui = 'bold' },
            b = { fg = colors.white, bg = colors.gray },
            c = { fg = colors.black, bg = colors.light_gray },
        },
        command = {
            a = { fg = colors.gray, bg = colors.cyan, gui = 'bold' },
            b = { fg = colors.gray, bg = colors.cyan },
            c = { fg = colors.gray, bg = colors.cyan },
        },
        inactive = {
            a = { fg = colors.light_gray, bg = colors.gray, gui = 'bold' },
            b = { fg = colors.light_gray, bg = colors.gray },
            c = { fg = colors.light_gray, bg = colors.gray },
        },
        normal = {
            a = { fg = colors.gray, bg = colors.cyan, gui = 'bold' },
            b = { fg = colors.white, bg = colors.gray },
            c = { fg = colors.black, bg = colors.light_gray },
        },
        insert = {
            a = { fg = colors.gray, bg = colors.magenta, gui = 'bold' },
            b = { fg = colors.white, bg = colors.gray },
            c = { fg = colors.black, bg = colors.light_gray },
        },
    }
end

local config = {}

function config.setup()
    local lualine = require('lualine')
    lualine.setup {
        options = {
            icons_enabled = true,
            theme = theme(),
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding'},
            lualine_y = {'searchcount', 'progress'},
            lualine_z = {'%l/%L'}
        },
        inactive_sections = {
            lualine_a = {{ 'mode', fmt = function(str) return str:sub(1,1) end }},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'searchcount', 'encoding', 'fileformat', { 'filetype', icons_enabled = false }},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
end

return config
