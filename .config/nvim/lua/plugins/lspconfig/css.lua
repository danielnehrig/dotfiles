local lspconfig = require("lspconfig")
local custom_attach = require("plugins.lspconfig").custom_attach

lspconfig.cssls.setup {on_attach = custom_attach}
