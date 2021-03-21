vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd completion-nvim]]

vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
local map = function(type, key, value)
	vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

vim.cmd [[set completeopt=menuone,noinsert,noselect]]

local custom_attach = function(client)
	require 'completion'.on_attach(client)

	map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
	map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
	map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
	map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
	map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
	map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
	map('n','<space>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
	map('n','<space>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
	map('n','<space>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n','<space>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
	map('n','<space>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
	map('n','<space>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
	map('n','<space>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
	map('n','<space>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
	map('n','<space>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
end

--  lsp for html , css and js/ts
require "lspconfig".tsserver.setup{on_attach=custom_attach}
require "lspconfig".rls.setup{on_attach=custom_attach}
require "lspconfig".cssls.setup{on_attach=custom_attach}
require "lspconfig".html.setup{on_attach=custom_attach}
require "lspconfig".rust_analyzer.setup{on_attach=custom_attach}
require "lspconfig".gopls.setup{on_attach=custom_attach}
require "lspconfig".pyright.setup{on_attach=custom_attach}

