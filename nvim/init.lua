-- Clear keymaps to start
vim.cmd("mapclear")

-- Core
require("config.keybindings")
require("config.functionality")
require("config.autocommands")
require("config.appearance")

-- Plugins
require("plugins")
