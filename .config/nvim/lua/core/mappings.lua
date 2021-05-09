local remap = vim.api.nvim_set_keymap
local home = require("core.global").home

local opt = {noremap = true, silent = true}

-- quickfix
remap("n", "<Leader>qc", ":cclose<CR>", opt)
remap("n", "<Leader>qn", ":cnext<CR>", opt)
remap("n", "<Leader>qo", ":copen<CR>", opt)
remap("n", "<Leader>qp", ":cprev<CR>", opt)
remap("n", "<Leader>qa", ":cc<CR>", opt)

-- locationlist
remap("n", "<Leader>lc", ":lclose<CR>", opt)
remap("n", "<Leader>ln", ":lnext<CR>", opt)
remap("n", "<Leader>lo", ":lopen<CR>", opt)
remap("n", "<Leader>lp", ":lprev<CR>", opt)
remap("n", "<Leader>la", ":ll<CR>", opt)

-- mappings
remap("n", "<Leader>ff", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", opt)
remap("n", "<Leader>fg", ":Telescope live_grep find_command=rg,--ignore,--hidden<CR>", opt)
remap("n", "<Leader>fb", ":Telescope buffers<CR>", opt)
remap("n", "<Leader>fh", ":Telescope help_tags<CR>", opt)
remap("n", "<Leader>fo", ":Telescope oldfiles<CR>", opt)
remap("n", "<C-p>", ":Telescope project<CR>", opt)

remap("n", "<Leader>fd", ":Telescope dotfiles path=" .. home .. "/.dotfiles-darwin/.config<CR>", opt)
remap("n", "<Leader>fn", ":Telescope file_create<CR>", opt)

remap("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- vimspector
remap("n", "<Leader>dl", [[ <Cmd>lua require'plugins.vimspector'.launch()<CR>]], opt)
vim.cmd [[command! Vimspector call vimspector#Launch()]]
