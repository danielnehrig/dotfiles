local lspconfig = require("lspconfig")
local augroups = require "utils".nvim_create_augroups

-- efm setups
local eslint = require("plugins.efm.eslint")
local prettier = require("plugins.efm.prettier")
local luafmt = require("plugins.efm.luafmt")
local rustfmt = require("plugins.efm.rustfmt")

-- formatting and linting with efm
lspconfig.efm.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        if client.resolved_capabilities.document_formatting then
            local autocmds = {
                Format = {
                    {"BufWritePre", "<buffer>", "lua vim.lsp.buf.formatting_sync()"}
                }
            }
            augroups(autocmds)
        end
    end,
    root_dir = function()
        return vim.fn.getcwd()
    end,
    init_options = {
        documentFormatting = true,
        codeAction = true
    },
    settings = {
        languages = {
            typescript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            lua = {luafmt},
            rust = {rustfmt}
        }
    },
    filetypes = {
        "lua",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    }
}
