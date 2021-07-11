local lspconfig = require("lspconfig")
local lsp = require("plugins.lspconfig")
local augroups = require "utils".nvim_create_augroups

lspconfig.rust_analyzer.setup {
    on_attach = function(client, bufnr)
        if client.resolved_capabilities.document_formatting then
            local autocmds = {
                Format = {
                    {"BufWritePre", "<buffer>", "lua vim.lsp.buf.formatting_sync()"}
                }
            }
            augroups(autocmds)
        end
        lsp.custom_attach(client, bufnr)
    end,
    capabilities = lsp.capabilities,
}
