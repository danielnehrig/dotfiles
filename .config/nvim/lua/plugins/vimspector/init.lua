local g = vim.g
local home = require("core.global").home

g.vimspector_install_gadgets = {"debugger-for-chrome", "vscode-node-debug2"}
g.vimspector_base_dir = home .. "/.config/nvim/plugins/vimspector/vimspector-config"