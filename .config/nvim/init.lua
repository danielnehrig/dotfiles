local cmd = vim.cmd
local g = vim.g

-- disable unused default plugins
local disabled_built_ins = {
  'gzip', 'man', 'matchparen', 'shada_plugin', 'tarPlugin', 'tar', 'zipPlugin', 'zip',
  'netrwPlugin'
}
for i = 1, 9 do g['loaded_' .. disabled_built_ins[i]] = 1 end

-- check if we are in vscode nvim
-- if not do not apply plugins
-- slows down vscode and makes it non usable
if not g.vscode then
  -- load packer plugins
  require("packer-config")

  -- setup conf and lua modules
  require("nvim_utils") -- loads global util functions
  require("core.global")
  require("core.options")
  require("core.mappings")
  require("core.highlights")
  require("core.autocmd")

  -- load configs for packer plugins
  require("plugins.testing")
  require("plugins.nvimTree")
  require("plugins.telescope")
  require("plugins.lspconfig")
  require("plugins.indent-blankline")
  require("plugins.bufferline")
  require("plugins.statusline")
  require("plugins.web-devicons")
  require("plugins.gitsigns")
  require("plugins.dashboard")
  require("plugins.which")
  require("plugins.swagger")
  require("plugins.autopairs")
  require("plugins.treesitter")
  require("plugins.gitlinker")

  -- setup plugins and init them
  -- those are not worth of own file extraction
  require("colorizer").setup()
  require("lspkind").init( { File = " " })
  -- matchit <> tag jump %
  cmd [[
    let b:match_words = '(:),\[:\],{:},<:>,' . '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
  ]]
end
