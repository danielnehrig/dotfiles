local global = require("core.global")
local M = require("utils")
local cmd = vim.cmd
local g = vim.g

local function load_options()
    cmd "filetype plugin on"
    cmd "syntax enable"
    cmd "syntax on"
    g.gruvbox_transparent_bg = 1
    g.mapleader = " "
    g.blamer_enabled = 1
    cmd "colorscheme gruvbox"
    vim.api.nvim_command("set foldmethod=expr")
    vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
    M.opt("o", "hidden", true)
    M.opt("o", "ignorecase", true)
    M.opt("o", "splitbelow", true)
    M.opt("o", "splitright", true)
    M.opt("o", "termguicolors", true)
    M.opt("o", "t_Co", "256")
    M.opt("o", "t_ut", "")
    M.opt("o", "background", "dark")
    M.opt("o", "relativenumber", true)
    M.opt("o", "numberwidth", 2)

    M.opt("o", "mouse", "a")

    M.opt("w", "signcolumn", "auto:2")
    M.opt("o", "cmdheight", 1)

    M.opt("o", "updatetime", 300) -- update interval for gitsigns
    M.opt("o", "clipboard", "unnamedplus")

    -- for indenline
    M.opt("b", "expandtab", true)
    M.opt("b", "shiftwidth", 2)
end

load_options()
