local remap = vim.api.nvim_set_keymap
local home = require("core.global").home

-- quickfix
remap("n", "<Leader>qc", ":cclose<CR>", {silent = true, noremap = true})
remap("n", "<Leader>qn", ":cnext<CR>", {silent = true, noremap = true})
remap("n", "<Leader>qo", ":copen<CR>", {silent = true, noremap = true})
remap("n", "<Leader>qp", ":cprev<CR>", {silent = true, noremap = true})
remap("n", "<Leader>qa", ":cc<CR>", {silent = true, noremap = true})
remap("n", "<Leader>r", ":lua require('nvim-reload').Reload()<CR>", {silent = true, noremap = true})

-- treesitter
remap("n", "<Leader>dh", ":TSBufToggle highlight<CR>", {silent = true, noremap = true}) -- disable highlight

-- vimspector
vim.cmd [[command! Vimspector call vimspector#Launch()]]
