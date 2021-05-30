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
    vim.opt.number = true
    vim.opt.relativenumber = true

    -- Set so that folders are index for find command
    vim.opt.path = vim.o.path .. "**/*"
    vim.opt.wildignore = vim.o.wildignore .. "node_modules,.git"

    -- neovide should not be transparent
    if not vim.g.neovide then
        g.gruvbox_transparent_bg = 1
    end

    g.mapleader = " "
    g.beacon_enable = 1

    -- Tag Jump
    b.match_words = table.concat({"(:),\\[:\\],{:},<:>,", "<\\@<=\\([^/][^ \t>]*\\)[^>]*\\%(>\\|$\\):<\\@<=/\1>"})

    cmd "colorscheme gruvbox" -- :)
    vim.opt.hidden = true -- buffer hidden
    vim.opt.ignorecase = true -- case sens ignore search
    vim.opt.splitbelow = true -- split behavior
    vim.opt.splitright = true -- split behavior
    vim.go.termguicolors = true
    vim.go.t_Co = "256"
    vim.go.t_ut = ""
    vim.opt.background = "dark" -- dark
    vim.opt.numberwidth = 2 -- width on numbeer row

    vim.opt.mouse = "a" -- mouse on don't use mouse lol

    vim.opt.signcolumn = "auto" -- 2 sign column
    vim.opt.cmdheight = 1
    vim.opt.guifont = "FiraCode Nerd Font Mono:h12"

    if vim.g.neovide then
        cmd('let g:neovide_cursor_vfx_mode = "pixiedust"')
    end

    vim.opt.updatetime = 300 -- update interval for gitsigns
    vim.opt.inccommand = "nosplit"
    vim.opt.timeoutlen = 500
    vim.opt.clipboard = "unnamedplus" -- clipboard yank

    -- for indenline
    -- indentation settings
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
end

load_options()
