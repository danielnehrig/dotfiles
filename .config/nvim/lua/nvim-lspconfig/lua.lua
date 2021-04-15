require 'lspsaga'
local map = require 'utils'.map
local autocmd = require 'utils'.autocmd
local lsp_status = require('lsp-status')
local cmd = vim.cmd
local fn = vim.fn
local setOption = vim.api.nvim_set_option

cmd [[packadd nvim-lspconfig]]
cmd [[packadd nvim-compe]]

setOption("omnifunc", "v:lua.vim.lsp.omnifunc")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- compe setup
require("compe").setup(
  {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    source = {
      path = true,
      buffer = true,
      calc = true,
      vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      spell = false,
      tags = false,
      snippets_nvim = true,
      treesitter = true
    }
  }
)

cmd [[set completeopt=menuone,noinsert,noselect]]

lsp_status.register_progress()
-- custom attach config
local custom_attach = function(client)
  lsp_status.on_attach(client)

  map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n','<space>gd','<cmd>lua require("lspsaga.provider").preview_definition()<CR>')
  -- map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n','K','<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
  map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
  -- map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n','gs','<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
  map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map('n','<space>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  map('n','<space>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  map('n','<space>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
  -- map('n','<space>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n','<space>af','<cmd>lua require("lspsaga.codeaction").code_action()<CR>')
  map('v','<space>ac','<cmd>lua require("lspsaga.codeaction").range_code_action()<CR>')
  map('n','<space>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
  --map('n','<space>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
  map('n','<space>ar','<cmd>lua require("lspsaga.rename").rename()<CR>')
  map('n','gh','<cmd>lua require("lspsaga.provider").lsp_finder()<CR>')
  map('n','<space>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  map('n','<space>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  map('n','<space>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
  map('i','<C-space>','<cmd>call compe#complete()<CR>')
  map('i','<TAB>','<cmd>call compe#confirm()<CR>')
  map('n','<space>cd','<cmd>lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>')


  autocmd("CursorHold", "<buffer>", "lua require'lspsaga.diagnostic'.show_line_diagnostics()")

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  fn.sign_define("LspDiagnosticsSignError", {text = "•"})
  fn.sign_define("LspDiagnosticsSignWarning", {text = "•"})
  fn.sign_define("LspDiagnosticsSignInformation", {text = "•"})
  fn.sign_define("LspDiagnosticsSignHint", {text = "•"})
  vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end
end

-- lsp setups
require "lspconfig".tsserver.setup{on_attach=custom_attach, capabilities=lsp_status.capabilities, handlers = lsp_status.extensions.clangd.setup()}
require "lspconfig".cssls.setup{on_attach=custom_attach}
require "lspconfig".html.setup{on_attach=custom_attach}
require "lspconfig".rust_analyzer.setup{on_attach=custom_attach, capabilities=capabilities}
require "lspconfig".gopls.setup{on_attach=custom_attach}
require "lspconfig".pyright.setup{on_attach=custom_attach}
require "lspconfig".dockerls.setup{on_attach=custom_attach}
require "lspconfig".clangd.setup{on_attach=custom_attach}
require "lspconfig".vimls.setup{on_attach=custom_attach}


-- lua sumenko
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
local sumneko_root_path = os.getenv('HOME') .. '/.dotfiles-darwin/lua-language-server'
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
          [fn.expand('$VIMRUNTIME/lua')] = true,
          [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
