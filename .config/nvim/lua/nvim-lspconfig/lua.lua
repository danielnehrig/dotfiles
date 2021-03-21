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
	map('i','<C-space>','<cmd>lua vim.lsp.buf.completion()<CR>')
end

require "lspconfig".tsserver.setup{on_attach=custom_attach}
require "lspconfig".rls.setup{on_attach=custom_attach}
require "lspconfig".cssls.setup{on_attach=custom_attach}
require "lspconfig".html.setup{on_attach=custom_attach}
require "lspconfig".rust_analyzer.setup{on_attach=custom_attach}
require "lspconfig".gopls.setup{on_attach=custom_attach}
require "lspconfig".pyright.setup{on_attach=custom_attach}
require "lspconfig".dockerls.setup{on_attach=custom_attach}
require "lspconfig".clangd.setup{on_attach=custom_attach}
require "lspconfig".vimls.setup{on_attach=custom_attach}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/Users/dnehrig/.dotfiles-darwin/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

require "lspconfig".sumneko_lua.setup {
	on_attach=custom_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
