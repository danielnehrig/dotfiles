local lspconfig = require("lspconfig")
local custom_attach = require("plugins.lspconfig").custom_attach

lspconfig.clangd.setup {on_attach = custom_attach}