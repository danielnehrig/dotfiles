local remap = vim.api.nvim_set_keymap
remap('n' , '<Leader>qc',':cclose<CR>', {silent = true , noremap = true})
remap('n' , '<Leader>qn',':cnext<CR>', {silent = true , noremap = true})
remap('n' , '<Leader>qo',':copen<CR>', {silent = true , noremap = true})
remap('n' , '<Leader>qp',':cprev<CR>', {silent = true , noremap = true})
