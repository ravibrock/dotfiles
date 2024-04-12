local cmp = require("cmp")
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

local kind_icons = {
    Class = "󰠱",
    Color = "󰏘",
    Constant = "󰏿",
    Constructor = "",
    Copilot = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰇽",
    File = "󰈙",
    Folder = "󰉋",
    Function = "󰊕",
    Interface = "",
    Keyword = "󰌋",
    Method = "󰆧",
    Module = "",
    Operator = "󰆕",
    Property = "󰜢",
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = "",
    TypeParameter = "󰅲",
    Unit = "",
    Value = "󰎠",
    Variable = "󰂡",
}

local options = {
    formatting = {
        fields = { "menu", "abbr", "kind" },
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
        end,
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
        ["<TAB>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "luasnip", option = { show_autosnippets = true } },
        { name = "vimtex" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    }),
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    experimental = {
        ghost_text = { hl_group = "LspCodeLens" },
    },
}
return options
