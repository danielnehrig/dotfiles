local cmd = vim.cmd
local g = vim.g

-- disable unused default plugins
local disabled_built_ins = {
  'gzip', 'man', 'matchparen', 'shada_plugin', 'tarPlugin', 'tar', 'zipPlugin', 'zip',
  'netrwPlugin'
}
for i = 1, 9 do g['loaded_' .. disabled_built_ins[i]] = 1 end

-- check if we are in vscode nvim
if not g.vscode then
  -- load plugins
  require("packer")
  -- setup conf and lua modules
  require("nvim_utils")
  require("mappings")
  require("highlights")
  require("autocmd")
  require("core.options")
  require("plugins.testing")
  require("plugins.nvimTree")
  require("plugins.telescope")
  require("plugins.lspconfig")
  require("plugins.indent-blankline")
  -- require("plugins.efm")
  require("plugins.bufferline")
  require("plugins.statusline")
  require("plugins.web-devicons")
  require("plugins.ale")
  require("plugins.gitsigns")
  require("plugins.dashboard")
  require("plugins.which")
  require("plugins.swagger")
  require("plugins.autopairs")
  require("plugins.treesitter")
  require("plugins.gitlinker")

  -- setup plugins and init them
  require("colorizer").setup()
  require("lspkind").init(
      {
          File = " "
      }
  )

  -- settings
  cmd [[
    let b:match_words = '(:),\[:\],{:},<:>,' . '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
  ]]
end
