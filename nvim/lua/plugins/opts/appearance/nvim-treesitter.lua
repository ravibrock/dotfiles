local options = {}
function options.setup()
	local treesitter = require("nvim-treesitter.configs")
	treesitter.setup{
        ensure_installed = {
            "bash",
            "c",
            "css",
            "html",
            "json",
            "lua",
            "markdown",
            "python",
            "query",
            "regex",
            "rust",
            "vim",
        },
        highlight = {
            disable = { "latex" },
            enable = true,
        },
	}
end
return options
