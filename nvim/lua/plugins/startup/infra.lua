local prefix = "plugins.opts.infra."
return {
    {
        "farmergreg/vim-lastplace",
        "tpope/vim-repeat",
    },
    {
        "micarmst/vim-spellsync",
        event = "VeryLazy",
    },
    {
        "aymericbeaumet/vim-symlink",
        dependencies = { "moll/vim-bbye" },
    },
    {
        "moll/vim-bbye",
        keys = {
            { "[b", "<CMD>Bdelete<CR>", mode = "n", desc = "Delete buffer" },
            { "]b", "<CMD>Bwipeout<CR>", mode = "n", desc = "Wipeout buffer" },
        },
    },
    {
        "numToStr/BufOnly.nvim",
        cmd = "BufOnly",
        keys = {{ "[B", "<CMD>BufOnly<CR>", desc = "Close all buffers except current" }},
    },
    {
        "nmac427/guess-indent.nvim",
        event = "BufRead",
        config = true,
    },
    {
        "akinsho/git-conflict.nvim",
        event = "BufReadPre",
        version = "*",
        config = true,
    },
    {
        "jghauser/mkdir.nvim",
        event = "BufWritePre",
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            "kristijanhusak/vim-dadbod-completion",
            "pbogut/vim-dadbod-ssh",
            "tpope/vim-dadbod",
        },
        keys = {{ "<leader>du", "<CMD>DBUITrigger<CR>", desc = "Trigger Dadbod UI" }},
        cmd = {
            "DB",
            "DBUI",
            "DBUITrigger",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        config = function()
            require(prefix .. "dadbod")
        end,
    },
    {
        "tpope/vim-dotenv",
        event = { "BufRead", "BufNewFile" },
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                callback = function()
                    local path = vim.fn.expand("%:p:h")
                    while path ~= "/" do
                        if vim.fn.filereadable(vim.fn.expand(path .. "/.env")) == 1 then
                            vim.cmd("Dotenv " .. path)
                        end
                        path = vim.fn.fnamemodify(path, ":h")
                    end
                end
            })
        end,
    },
    {
        "is0n/jaq-nvim",
        cmd = "Jaq",
        keys = {
            { "<leader>jb", "<CMD>Jaq bang<CR>", desc = "Jaq small popup" },
            { "<leader>ji", "<CMD>Jaq internal<CR>", desc = "Jaq internal" },
            { "<leader>jj", "<CMD>Jaq<CR>", desc = "Jaq" },
        },
        opts = {
            cmds = {
                internal = {
                    lua = "luafile %",
                    vim = "source %",
                },
                external = {
                    bash     = "bash %",
                    c        = "gcc -std=c99 -Wall % -o tempout && ./tempout; rm -f tempout",
                    markdown = "glow %",
                    python   = "python3 %",
                    zsh      = "zsh %",
                },
            },
        },
    },
    {
        "sontungexpt/url-open",
        keys = {{ "<leader>lo", "<CMD>URLOpenUnderCursor<CR>", desc = "Open URL under cursor" }},
        config = function()
            local status_ok, url_open = pcall(require, "url-open")
            if not status_ok then return end
            url_open.setup({
                highlight_url = {
                    cursor_move = { enabled = false },
                },
            })
        end,
    },
    {
        "lewis6991/hover.nvim",
        opts = {
            init = function()
                require("hover.providers.lsp")
                require("hover.providers.dap")
                require("hover.providers.gh")
                require("hover.providers.gh_user")
                require("hover.providers.man")
                require("hover.providers.dictionary")
            end,
            preview_window = false,
            title = true,
        },
        keys = {
            --- @diagnostic disable: missing-parameter
            {
                "K",
                function()
                    require("hover").hover()
                end,
                desc = "Hover",
            },
            {
                "gK",
                function()
                    require("hover").hover_select()
                end,
                desc = "Hover (select)",
            },
            {
                "<S-TAB>",
                function()
                    require("hover").hover_switch("previous")
                end,
                desc = "Hover (previous)",
            },
            {
                "<TAB>",
                function()
                    require("hover").hover_switch("next")
                end,
                desc = "Hover (next)",
            },
        },
        --- @diagnostic enable: missing-parameter
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        build = ":MasonUpdate",
        config = function()
            require(prefix .. "mason")
            -- Try running following if Mason/Node can't install:
            -- sudo chown -R $USER:$GROUP ~/.npm
        end,
    },
    {
        "vyfor/cord.nvim",
        event = "VeryLazy",
        build = "./build",
        opts = {
            display = {
                show_repository = false,
                show_cursor_position = false,
            },
            text = {
                viewing = "Coding ✍️",
                editing = "Coding ✍️",
                file_browser = "Browsing files 📑",
                plugin_manager = "Managing plugins 🔌",
                workspace = "",
            },
        },
    },
    {
        "tpope/vim-eunuch",
        cmd = {
            "Rename",
            "Move",
            "Delete",
            "SudoWrite",
            "SudoEdit",
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "folke/neodev.nvim",
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
        },
        config = function()
            require(prefix .. "mason-lspconfig")
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvimtools/none-ls.nvim",
            "williamboman/mason.nvim",
        },
        config = function()
            require(prefix .. "mason-null-ls")
        end,
    },
    {
        "williamboman/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        },
        config = function()
            require(prefix .. "mason-nvim-dap")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = {
            "aznhe21/actions-preview.nvim",
            "chrisgrieser/nvim-rulebook",
        },
        config = function()
            require(prefix .. "nvim-lspconfig")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = true,
        init = function()
            vim.fn.sign_define("DapBreakpoint", { text="" })
            vim.fn.sign_define("DapBreakpointCondition", { text="" })
            vim.fn.sign_define("DapBreakpointRejected", { text="" })
            vim.fn.sign_define("DapLogPoint", { text="" })
        end,
        keys = function()
            return require(prefix .. "nvim-dap")
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "kevinhwang91/promise-async",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require(prefix .. "nvim-ufo")
        end,
    },
    {
        "stevearc/stickybuf.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "tpope/vim-fugitive",
        dependencies = { "tpope/vim-rhubarb" },
        cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
        config = function()
            local function forcepush()
                local choice = vim.fn.input("Force push? [Y/n] ")
                vim.cmd("normal! :<CR>")
                if choice == "Y" then
                    vim.cmd("Git push --force-with-lease")
                else
                    print("Force push aborted.")
                end
            end
            vim.api.nvim_create_user_command("GForcePush", forcepush, {})
        end,
        keys = {
            { "<leader>gb", "<CMD>Git blame<CR>", desc = "Blame current file" },
            { "<leader>gc", "<CMD>Git commit -a <BAR> startinsert<CR>", desc = "Commit" },
            { "<leader>gd", "<CMD>Gdiffsplit<CR>", desc = "Diff" },
            { "<leader>gf", "<CMD>GForcePush<CR>", desc = "Force push" },
            { "<leader>gl", "<CMD>Git pull<CR>", desc = "Pull" },
            { "<leader>go", "<CMD>GBrowse<CR>", desc = "Open in GitHub" },
            { "<leader>gp", "<CMD>Git push<CR>", desc = "Push" },
            { "<leader>gr", "<CMD>Git rebase -i --root<CR>", desc = "Rebase" },
            { "<leader>gs", "<CMD>Git<CR>", desc = "Status" },
        },
    },
    {
        "turbio/bracey.vim",
        ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        build = "npm install --no-package-lock --prefix server",
        config = function()
            vim.keymap.set("n", "<leader>bb", "<CMD>Bracey<CR>", { noremap = true, desc = "Start Bracey preview" })
            vim.keymap.set("n", "<leader>br", "<CMD>BraceyReload<CR>", { noremap = true, desc = "Reload Bracey" })
            vim.keymap.set("n", "<leader>bs", "<CMD>BraceyStop<CR>", { noremap = true, desc = "Stop Bracey preview" })
        end,
    },
    {
        "lervag/vimtex",
        ft = { "tex" },
        cmd = { "VimtexClean", "VimtexCompile", "VimtexInverseSearch", "VimtexView" },
        keys = {
            { "<leader>lc", "<CMD>VimtexClean<CR>", desc = "Clean TeX auxfiles" },
            { "<leader>ll", "<CMD>VimtexCompile<CR>", desc = "Start TeX compilation" },
            { "<leader>ls", "<CMD>silent! !sioyek --execute-command reload<CR>", desc = "Reload Sioyek instance" },
            { "<leader>lv", "<CMD>VimtexView<CR>", desc = "View compiled TeX document" },
            { "<leader>lw", "<CMD>VimtexCountWords<CR>", desc = "Count words in TeX file" },
        },
        config = function()
            require(prefix .. "vimtex")
        end,
    },
    {
        "rawnly/gist.nvim",
        cmd = { "GistCreate", "GistCreateFromFile" },
        config = true,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make",
    },
    {
        "olimorris/persisted.nvim",
        cmd = { "SessionLoad", "SessionLoadLast" },
        opts = {
            use_git_branch = true,
            should_autosave = function()
                if vim.bo.filetype == "alpha" then
                    return false
                end
                return true
            end,
        },
    },
}
