local remap = vim.api.nvim_set_keymap
require("trouble").setup {}

remap("n", "<Leader>qt", ":LspTroubleToggle<CR>", {silent = true, noremap = true})
