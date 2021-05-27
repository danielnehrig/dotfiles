local M = require("utils")
local cmd = vim.cmd
local g, b = vim.g, vim.b
-- local autocmd = require "utils".autocmd

local function load_options()
    -- default vim stuff
    cmd "syntax enable"
    cmd "syntax on"

    -- activate line numbers
    -- TODO: make toggleable for pair programming
    vim.api.nvim_win_set_option(0, "number", true)
    vim.api.nvim_win_set_option(0, "relativenumber", true)

    -- Set so that folders are index for find command
    vim.o.path = vim.o.path .. "**/*"
    vim.o.wildignore = vim.o.wildignore .. "node_modules,.git"

    -- save view on leave and load on buf enter
    -- used for manuall fold loading
    -- autocmd("BufWinLeave", "*.*", "mkview")
    -- autocmd("BufWinEnter", "*.*", "silent loadview")

    -- neovide should not be transparent
    if not vim.g.neovide then
        g.gruvbox_transparent_bg = 1
    end

    g.mapleader = " "
    g.beacon_enable = 1

    -- Tag Jump
    b.match_words = table.concat({"(:),\\[:\\],{:},<:>,", "<\\@<=\\([^/][^ \t>]*\\)[^>]*\\%(>\\|$\\):<\\@<=/\1>"})

    cmd "colorscheme gruvbox" -- :)
    M.opt("o", "hidden", true) -- buffer hidden
    M.opt("o", "ignorecase", true) -- case sens ignore search
    M.opt("o", "splitbelow", true) -- split behavior
    M.opt("o", "splitright", true) -- split behavior
    M.opt("o", "termguicolors", true) -- color stuff
    M.opt("o", "t_Co", "256") -- color stuff
    M.opt("o", "t_ut", "")
    M.opt("o", "background", "dark") -- dark
    M.opt("o", "numberwidth", 2) -- width on numbeer row

    M.opt("o", "mouse", "a") -- mouse on don't use mouse lol

    M.opt("w", "signcolumn", "auto") -- 2 sign column
    M.opt("o", "cmdheight", 1)
    M.opt("o", "guifont", "FiraCode Nerd Font Mono:h12")

    if vim.g.neovide then
        cmd('let g:neovide_cursor_vfx_mode = "pixiedust"')
    end

    M.opt("o", "updatetime", 300) -- update interval for gitsigns
    M.opt("o", "inccommand", "nosplit")
    vim.cmd("set timeoutlen=500")
    M.opt("o", "clipboard", "unnamedplus") -- clipboard yank

    -- for indenline
    -- indentation settings
    M.opt("b", "expandtab", true)
    M.opt("b", "shiftwidth", 2)
end

load_options()
