local map = vim.api.nvim_set_keymap

vim.cmd("set timeoutlen=500")
vim.api.nvim_set_keymap('n', '<Space>', ':WhichKey "<Space>"<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<g>', ':WhichKey "g"<CR>', { noremap = true, silent = true })

