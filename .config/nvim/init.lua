local cmd = vim.cmd
local g = vim.g
local nvim_command = vim.api.nvim_command
local remap = vim.api.nvim_set_keymap

local disabled_built_ins = {
  'gzip', 'man', 'matchit', 'matchparen', 'shada_plugin', 'tarPlugin', 'tar', 'zipPlugin', 'zip',
  'netrwPlugin'
}
for i = 1, 10 do g['loaded_' .. disabled_built_ins[i]] = 1 end

if not g.vscode then
  local npairs = require('nvim-autopairs')

  -- load plugins
  require("pluginsList.lua")

  -- setup conf
  require("core.options")
  require("utils")
  require("testing")
  require("nvimTree.lua")
  require("telescope-nvim.lua")
  require("nvim-lspconfig.lua")
  require("bufferline.lua")
  require("statusline.lua")
  require("web-devicons.lua")
  require("ale")
  require("gitsigns.lua")
  require("dashboard")
  require("which")
  require 'swagger'
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
    indent = {
      enable = false
    }
  }

  -- other
  require 'snippets'
  require "colorizer".setup()
  require("nvim-autopairs").setup()
  require 'nvim_utils'
  require("lspkind").init(
      {
          File = " "
      }
  )

  cmd "syntax enable"
  cmd "syntax on"

  -- settings
  g.indentLine_enabled = 0
  g.indent_blankline_enabled = 0
  g.indentLine_char_list = {"▏"}
  cmd "set termguicolors"
  g.mapleader = " "

  g.blamer_enabled = 1
  -- colorscheme
  g.gruvbox_transparent_bg=1
  cmd "colorscheme gruvbox"

  -- misc
  cmd "set foldmethod=expr"
  cmd "set foldexpr=nvim_treesitter#foldexpr()"

  -- tmux color stuff
  cmd [[
    if exists("$TMUX")
      let &t_RB = "\ePtmux;\e\e]11;?\007\e\\"
    endif
    set t_8f=^[[38;2;%lu;%lu;%lum
    set t_8b=^[[48;2;%lu;%lu;%lum
    set termguicolors
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
  remap('n' , '<Leader>qn',':cnext<CR>', {silent = true , noremap = true})
  remap('n' , '<Leader>qo',':copen<CR>', {silent = true , noremap = true})
  remap('n' , '<Leader>qc',':cclose<CR>', {silent = true , noremap = true})
  remap('n' , '<Leader>qp',':cprev<CR>', {silent = true , noremap = true})
  -- autocmd au groups to trigger differently
  -- depending on action and file types etc
  local definitions = {
    ft = {
      {"FileType", "dashboard", "set showtabline=0"};
      {"FileType", "dashboard", "let g:indentLine_enabled=0"};
      {"FileType", "dashboard", "let g:indent_blankline_enabled=0"};
      {"FileType", "dashboard", "let g:indent_blankline_namespace=0"};
      {"BufNewFile,BufRead","*","set showtabline=2"},
      {"BufNewFile,BufRead","*","let g:indentLine_enabled=1"},
      {"BufNewFile,BufRead","*","let g:indent_blankline_enabled=1"},
      {"BufNewFile,BufRead","*","let g:indent_blankline_namespace=18"},
      {"BufNewFile,BufRead","*.toml"," setf toml"},
    };
  }

  nvim_create_augroups(definitions)


  -- MAPPING FOR AUTOPAIRS INDENT INSIDE BRACKETS

  _G.MUtils= {}

  vim.g.completion_confirm_key = ""

  MUtils.completion_confirm=function()
    if vim.fn.pumvisible() ~= 0  then
      if vim.fn.complete_info()["selected"] ~= -1 then
        vim.fn["compe#confirm"]()
        return npairs.esc("<c-y>")
      else
        vim.defer_fn(function()
          vim.fn["compe#confirm"]("<cr>")
        end, 20)
        return npairs.esc("<c-n>")
      end
    else
      return npairs.check_break_line_char()
    end
  end


  remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
end
