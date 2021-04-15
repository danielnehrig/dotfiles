local remap = vim.api.nvim_set_keymap
local home = require('core.global').home
-- quickfix
remap('n' , '<Leader>qc',':cclose<CR>', {silent = true , noremap = true})
remap('n' , '<Leader>qn',':cnext<CR>', {silent = true , noremap = true})
remap('n' , '<Leader>qo',':copen<CR>', {silent = true , noremap = true})
remap('n' , '<Leader>qp',':cprev<CR>', {silent = true , noremap = true})

-- telescope
remap('n' , '<Leader>fd',':Telescope dotfiles path=' .. home .. '/.dotfiles-darwin/.config<CR>', {silent = true , noremap = true})
