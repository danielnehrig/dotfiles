-- load plugins
require("pluginsList.lua")
require("web-devicons.lua")

require("utils.lua")
require("testing.init")
require("nvimTree.lua")
require("bufferline.lua")
require("statusline.lua")
require("telescope-nvim.lua")

-- lsp
require("nvim-lspconfig.lua")
-- require("efm")
require("ale.lua")

require("gitsigns.lua")
require("startify")

require "colorizer".setup()

local cmd = vim.cmd
local g = vim.g

cmd "syntax enable"
cmd "syntax on"

g.auto_save = 1
g.indentLine_enabled = 1
g.indentLine_char_list = {"▏"}

g.mapleader = " "

require("treesitter.lua")

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

require("nvim-autopairs").setup()
require('nvim-ts-autotag').setup()

require("lspkind").init(
    {
        File = " "
    }
)

cmd("hi CustomExplorerBg guibg=#242830")

vim.api.nvim_exec(
[[
  augroup NvimTree 
    au!
    au FileType NvimTree setlocal winhighlight=Normal:CustomExplorerBg
   augroup END
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_transparent_bg = 1
  set background=dark

  colorscheme gruvbox
]],
  false
)
