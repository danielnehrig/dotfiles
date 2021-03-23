-- load plugins
require("pluginsList.lua")
-- setup conf
require("core.options")
require("web-devicons.lua")
require("utils.lua")
require("testing")
require("nvimTree.lua")
require("bufferline.lua")
require("statusline.lua")
require("telescope-nvim.lua")
require("nvim-lspconfig.lua")
require("ale.lua")
require("gitsigns.lua")
require("dashboard")
require "colorizer".setup()

local cmd = vim.cmd
local g = vim.g

cmd "syntax enable"
cmd "syntax on"

-- settings
g.auto_save = 1
g.indentLine_enabled = 1
g.indentLine_char_list = {"▏"}
g.mapleader = " "

-- colorscheme
g.gruvbox_contrast_dark = 'hard'
g.gruvbox_transparent_bg = 1
cmd "colorscheme gruvbox"


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
cmd("hi CustomExplorerBg guibg=#242830")

require("nvim-autopairs").setup()
require('nvim-ts-autotag').setup()
require("lspkind").init(
    {
        File = " "
    }
)


-- MAPPING FOR AUTOPAIRS INDENT INSIDE BRACKETS
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
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
