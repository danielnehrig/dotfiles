local cmd = vim.cmd
local g = vim.g
local b = vim.b
local nvim_command = vim.api.nvim_command
local remap = vim.api.nvim_set_keymap

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

  -- highlights
  cmd("hi LineNr guibg=NONE")
  cmd("hi SignColumn guibg=NONE")
  cmd("hi VertSplit guibg=NONE")
  cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
  cmd("hi DiffChange guifg =#3A3E44 guibg = none")
  cmd("hi DiffModified guifg = #81A1C1 guibg = none")
  cmd("hi EndOfBuffer guifg=#282c34")

  cmd("hi TelescopeBorder   guifg=#3e4451")
  cmd("hi TelescopePromptBorder   guifg=#3e4451")
  cmd("hi TelescopeResultsBorder  guifg=#3e4451")
  cmd("hi TelescopePreviewBorder  guifg=#525865")
  cmd("hi PmenuSel  guibg=#98c379")

  -- tree folder name , icon color
  cmd("hi NvimTreeFolderIcon guifg = #61afef")
  cmd("hi NvimTreeFolderName guifg = #61afef")
  cmd("hi NvimTreeIndentMarker guifg=#545862")
  cmd("hi CustomExplorerBg guibg=#242830")
  nvim_command('autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0')
  g.mapleader = " "

  -- autocmd au groups to trigger differently
  -- depending on action and file types etc
  local definitions = {
    ft = {
      {"FileType", "dashboard", "set showtabline=0"};
      {"BufNewFile,BufRead","*","set showtabline=2"},
      {"BufNewFile,BufRead","*.toml"," setf toml"},
    };
  }

  nvim_create_augroups(definitions)
end
