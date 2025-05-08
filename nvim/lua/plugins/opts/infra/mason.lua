require("mason").setup({
    ui = {
        icons = {
            package_uninstalled = " ",
            package_pending = "󱑤 ",
            package_installed = "󰄳 ",
        },
    },
})

local M = {}
function M.update_all()
    local registry = require("mason-registry")
    local updated = false
    registry.update(function(success, err)
        if not success then
            print("[mason-update-all] error fetching updates: " .. err)
            return
        end
        for _, pkg in ipairs(registry.get_installed_packages()) do
            local latest_version = pkg:get_latest_version()
            if pkg:get_installed_version() ~= latest_version then
                updated = true
                print("[mason-update-all] updating " .. pkg.name)
                pkg:install():on("closed", function()
                    print("[mason-update-all] updated " .. pkg.name .. " to " .. latest_version)
                end)
            end
        end
    end)
    return updated
end

function M.usercmd()
    if not M.update_all() then
        print("[mason-update-all] all packages up-to-date")
    end
end

vim.api.nvim_create_user_command("MasonUpdateAll", M.usercmd, {})
M.update_all()
