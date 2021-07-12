local custom_attach = require("plugins.lspconfig").custom_attach
local capabilities = require("plugins.lspconfig").capabilities
local lspconfig = require("lspconfig")

lspconfig.tsserver.setup {
    filetypes = {"typescript", "typescriptreact"},
    capabilities = capabilities,
    flags = {debounce_text_changes = 500},
    on_attach = function(client, bufnr)
        -- disable TS formatting since we use efm
        client.resolved_capabilities.document_formatting = false

        custom_attach(client, bufnr)
    end
}
