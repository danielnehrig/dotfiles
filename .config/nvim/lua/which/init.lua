local map = require'utils'.map

vim.g.mapleader = "<Space>"
vim.g.maplocalleader = ','

map('n','<leader>','<cmd>WhichKey "<Space>"<CR>')
map('n','<localleader>','<cmd>WhichKey ","<CR>')
