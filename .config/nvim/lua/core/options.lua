local M = require("utils")
local cmd = vim.cmd
local g, b, opt, go = vim.g, vim.b, vim.opt, vim.go
-- local autocmd = require "utils".autocmd

local function load_options()
    -- activate line numbers
    -- TODO: make toggleable for pair programming
    opt.number = true
    opt.relativenumber = true

    -- Set so that folders are index for find command
    opt.path:append("**/*")
    opt.wildignore:append("node_modules,.git")

    -- neovide should not be transparent
    if not g.neovide then
        g.gruvbox_transparent_bg = 1
    end

    g.mapleader = " "
    g.beacon_enable = 1

    -- Tag Jump
    b.match_words = table.concat({"(:),\\[:\\],{:},<:>,", "<\\@<=\\([^/][^ \t>]*\\)[^>]*\\%(>\\|$\\):<\\@<=/\1>"})

    cmd "colorscheme gruvbox" -- :)
    opt.hidden = true -- buffer hidden
    opt.ignorecase = true -- case sens ignore search
    opt.splitbelow = true -- split behavior
    opt.splitright = true -- split behavior
    go.termguicolors = true
    go.t_Co = "256"
    go.t_ut = ""
    opt.background = "dark" -- dark
    opt.numberwidth = 2 -- width on numbeer row

    opt.mouse = "a" -- mouse on don't use mouse lol

    opt.signcolumn = "auto" -- 2 sign column
    opt.cmdheight = 1
    opt.guifont = "FiraCode Nerd Font Mono:h12"

    if g.neovide then
        cmd('let g:neovide_cursor_vfx_mode = "pixiedust"')
    end

    opt.updatetime = 300 -- update interval for gitsigns
    opt.inccommand = "nosplit"
    opt.timeoutlen = 500
    opt.clipboard = "unnamedplus" -- clipboard yank

    -- for indenline
    -- indentation settings
    opt.expandtab = true
    opt.shiftwidth = 2
end

load_options()
