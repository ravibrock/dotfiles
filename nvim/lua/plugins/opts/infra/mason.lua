require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_uninstalled = " ",
            package_pending = "󱑤 ",
            package_installed = "󰄳 ",
        },
    },
})

require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
    function(server)
        require("lspconfig")[server].setup({ capabilities = vim.lsp.protocol.make_client_capabilities() })
    end,
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = { globals = "vim" },
                    runtime = { version = "LuaJIT" },
                    telemetry = { enable = false },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })
    end,
})

local M = {}
function M.update_all()
    local registry = require("mason-registry")
    local updated = 0
    registry.update(function(success, err)
        if not success then
            print("[mason-update-all] error fetching updates: " .. err)
            return
        end
        for _, pkg in ipairs(registry.get_installed_packages()) do
            pkg:check_new_version(function(new_available, version)
                if new_available then
                    updated = 1
                    print("[mason-update-all] updating " .. pkg.name)
                    pkg:install():on("closed", function()
                        print("[mason-update-all] updated " .. pkg.name .. " to " .. version.latest_version)
                    end)
                end
            end)
        end
    end)
    return updated
end

function M.usercmd()
    if M.update_all() == 0 then
        print("[mason-update-all] all packages up-to-date")
    end
end

vim.api.nvim_create_user_command("MasonUpdateAll", M.usercmd, {})
M.update_all()
