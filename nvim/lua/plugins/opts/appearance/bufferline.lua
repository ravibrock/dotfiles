local config = {}
function config.setup()
    local bufferline = require("bufferline")
    bufferline.setup({
        options = {
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
            always_show_bufferline = false,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                    separator = true,
                },
            },
        },
        highlights = {
            fill = {
                fg = '#02040A',
                bg = '#02040A',
            },
            separator = {
                bg = '#0E1117',
                fg = '#454759',
            },
            separator_selected = {
                bg = '#0E1117',
                fg = '#454759',
            },
            separator_visible = {
                bg = '#0E1117',
                fg = '#454759',
            },
            tab_separator = {
                bg = '#0E1117',
                fg = '#454759',
            },
            tab_separator_selected = {
                bg = '#0E1117',
                fg = '#454759',
            },
            tab_close = {
                bg = '#020309',
                fg = '#454759',
            },
        },
    })
end

return config
