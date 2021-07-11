local custom_attach = require("plugins.lspconfig").custom_attach
local lspconfig = require("lspconfig")

lspconfig.tsserver.setup {
    filetypes = {"typescript", "typescriptreact"},
    on_attach = function(client, bufnr)
        -- disable TS formatting since we use efm
        client.resolved_capabilities.document_formatting = false

        custom_attach(client, bufnr)
    end
}
