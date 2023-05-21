local cmp = require("cmp")
local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
    Copilot = "",
}

local options = {
    formatting = {
        fields = {"menu", "abbr", "kind"},
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                copilot = "",
                buffer = "󰂡",
                latex_symbols = "󰍘",
                luasnip = "⋗",
                nvim_lsp = "λ",
                nvim_lua = "",
                path = "󰉋",
            })[entry.source.name]
            return vim_item
        end
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered({
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None"
        }),
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "luasnip", option = { show_autosnippets = true } },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    }),
    experimental = {
        ghost_text = {
            hl_group = "LspCodeLens",
        },
    },
}
return options
