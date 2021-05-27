local cmd = vim.cmd
local g = vim.g

-- check if we are in vscode nvim
-- if not do not apply plugins
-- slows down vscode and makes it non usable
if not g.vscode then
    -- load packer plugins
    local pack = require("packer-config")
    pack.ensure_plugins()
    pack.load_compile()

    -- setup conf and lua modules
    require("core.global")
    require("core.options")
    require("core.mappings")
    require("core.highlights")
    require("core.autocmd")

    -- load configs for packer plugins
    require("plugins.build")
    require("plugins.coverage")
    require("plugins.lspconfig")
    require("plugins.indent-blankline")
    require("plugins.bufferline")
    require("plugins.statusline")
    require("plugins.web-devicons")
    require("plugins.dashboard")
    require("plugins.which")
    require("plugins.swagger")
    require("plugins.autopairs")
    require("plugins.nvimTree")
    require("plugins.treesitter")

    -- setup plugins and init them
    -- those are not worth of own file extraction
    require("colorizer").setup()
    require("lspkind").init({File = " "})
end
