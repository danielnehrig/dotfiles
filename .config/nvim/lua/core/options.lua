local global = require("core.global")
local M = require("utils")
local cmd = vim.cmd
local g = vim.g

local function load_options()
    cmd "filetype plugin on"
    cmd "syntax enable"
    cmd "syntax on"
    if not vim.g.neovide then
        g.gruvbox_transparent_bg = 1
    end
    g.mapleader = " "
    g.blamer_enabled = 1
    cmd "colorscheme gruvbox"
    vim.api.nvim_command("set foldmethod=expr")
    vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
    M.opt("o", "hidden", true) -- buffer hidden
    M.opt("o", "ignorecase", true) -- case sens ignore search
    M.opt("o", "splitbelow", true) -- split behavior
    M.opt("o", "splitright", true) -- split behavior
    M.opt("o", "termguicolors", true) -- color stuff
    M.opt("o", "t_Co", "256") -- color stuff
    M.opt("o", "t_ut", "")
    M.opt("o", "background", "dark") -- dark
    M.opt("o", "relativenumber", true) -- relative number to jump with jk
    M.opt("o", "number", true) -- cursor line G number
    M.opt("o", "numberwidth", 2) -- width on numbeer row

    M.opt("o", "mouse", "a") -- mouse on don't use mouse lol

    M.opt("w", "signcolumn", "auto:2") -- 2 sign column
    M.opt("o", "cmdheight", 1)
    M.opt("o", "guifont", "FiraCode Nerd Font Mono:h12")

    if vim.g.neovide then
        cmd('let g:neovide_cursor_vfx_mode = "pixiedust"')
    end

    M.opt("o", "updatetime", 300) -- update interval for gitsigns
    M.opt("o", "clipboard", "unnamedplus") -- clipboard yank

    -- for indenline
    M.opt("b", "expandtab", true)
    M.opt("b", "shiftwidth", 2)
end

load_options()
