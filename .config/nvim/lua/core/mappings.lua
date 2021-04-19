local remap = vim.api.nvim_set_keymap
local home = require("core.global").home

-- quickfix
remap("n", "<Leader>qc", ":cclose<CR>", {silent = true, noremap = true})
remap("n", "<Leader>qn", ":cnext<CR>", {silent = true, noremap = true})
remap("n", "<Leader>qo", ":copen<CR>", {silent = true, noremap = true})
remap("n", "<Leader>qp", ":cprev<CR>", {silent = true, noremap = true})
remap("n", "<Leader>r", ":lua require('utils').clear_cache()<CR>", {silent = true, noremap = true})

-- telescope
remap(
    "n",
    "<Leader>fd",
    ":Telescope dotfiles path=" .. home .. "/.dotfiles-darwin/.config<CR>",
    {silent = true, noremap = true}
)

-- treesitter
remap("n", "<Leader>dh", ":TSBufToggle highlight<CR>", {silent = true, noremap = true}) -- disable highlight
