local map = require 'utils'.map
local lsp_config = require('lspconfig')
local autocmd = require 'utils'.autocmd
local eslint = require('efm.eslint')
local lsp_status = require('lsp-status')
local prettier = require('efm.prettier')
local fn = vim.fn

local function buf_option(...)
  vim.api.nvim_buf_set_option(bufnr, ...)
end

local function on_attach(client)
  buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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
end

local efm_config = os.getenv('HOME') .. '/.config/nvim/lua/efm/config.yaml'
local efm_log_dir = os.getenv('HOME') .. '/.temp/'
local efm_root_markers = { 'package.json', '.git/', '.zshrc' }
local efm_languages = {
  yaml = { prettier },
  json = { prettier },
  markdown = { prettier },
  javascript = { eslint, prettier },
  javascriptreact = { eslint, prettier },
  ["javascript.jsx"] = { eslint, prettier },
  typescript = { eslint, prettier },
  typescriptreact = { eslint, prettier },
  ["typescript.tsx"] = { eslint, prettier },
  css = { prettier },
  scss = { prettier },
  sass = { prettier },
  less = { prettier },
  graphql = { prettier },
  vue = { prettier },
  html = { prettier }
}

lsp_config.efm.setup({
  cmd = {
    "efm-langserver",
    "-c",
    efm_config,
    "-logfile",
    efm_log_dir .. "efm.log"
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx'
  },
  on_attach = on_attach,
  root_dir = lsp_config.util.root_pattern(unpack(efm_root_markers)),
  init_options = {
    documentFormatting = true
  },
  settings = {
    rootMarkers = efm_root_markers,
    languages = efm_languages
  }
})
