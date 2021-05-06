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
remap("n", "<Leader>la", ":lc<CR>", opt)

-- reload
remap("n", "<Leader>r", ":lua require('nvim-reload').Reload()<CR>", opt)

-- treesitter
remap("n", "<Leader>dh", ":TSBufToggle highlight<CR>", opt) -- disable highlight

-- mappings
remap("n", "<Leader>ff", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", opt)
remap("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
remap("n", "<Leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opt)
remap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
remap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
remap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
remap("n", "<C-p>", [[<Cmd>lua require'telescope'.extensions.project.project{}<CR>]], opt)

remap("n", "<Leader>fd", ":Telescope dotfiles path=" .. home .. "/.dotfiles-darwin/.config<CR>", opt)
remap("n", "<Leader>fn", ":Telescope file_create<CR>", opt)

remap("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- vimspector
vim.cmd [[command! Vimspector call vimspector#Launch()]]
