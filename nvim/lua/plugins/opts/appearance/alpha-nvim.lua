local all = {}
all.opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local santa = [[                                                        *
     *                                                          *
                                  *                  *        .--.
      \/ \/  \/  \/                                        ./   /=*
        \/     \/      *            *                ...  (_____)
         \ ^ ^/                                       \ \_((^o^))-.     *
         (o)(O)--)--------\.              N V I M      \   (   ) \  \._.
         |    |  ||================((~~~~~~~~~~~~~~~~~))|   ( )   |     \
          \__/             ,|        \. * * * * * * ./  (~~~~~~~~~~~)    \
   *        ||^||\.____./|| |          \___________/     ~||~~~~|~'\____/ *
            || ||     || || A            ||    ||          ||    |
     *      <> <>     <> <>          (___||____||_____)   ((~~~~~|   *]]
    dashboard.section.header.val = vim.split(santa, "\n")
    dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " New file", "<CMD>ene <BAR> startinsert<CR>"),
        dashboard.button("r", " " .. " Recent files", "<CMD>Telescope oldfiles<CR>"),
        dashboard.button("f", "󰍉 " .. " Find file", "<CMD>Telescope find_files<CR>"),
        dashboard.button("g", " " .. " Find text", "<CMD>Telescope live_grep<CR>"),
        dashboard.button("s", " " .. " Restore Session", "<CMD>SessionLoadLast<CR>"),
        dashboard.button("c", " " .. " Config", "<CMD>e $MYVIMRC<CR>"),
        dashboard.button("m", "󱊍 " .. " Mason", "<CMD>Mason<CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy", "<CMD>Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", "<CMD>qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
    return dashboard
end
all.config = function(_, dashboard)
    if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            callback = function()
                require("lazy").show()
            end,
        })
    end
    require("alpha").setup(dashboard.opts)
    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local version = vim.version()
            local v = version.major .. "." .. version.minor .. "." .. version.patch
            dashboard.section.footer.val = "⚡ Neovim v" .. v .. " loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            pcall(vim.cmd.AlphaRedraw)
        end,
    })
end
return all
