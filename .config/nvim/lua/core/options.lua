local cmd = vim.cmd
local g, b, opt, go = vim.g, vim.b, vim.opt, vim.go
local nvim_command = vim.api.nvim_command
-- local autocmd = require "utils".autocmd

local function load_options()
    opt.shadafile = "NONE"
    -- activate line numbers
    -- TODO: make toggleable for pair programming
    opt.number = true -- enable numbers
    opt.relativenumber = true -- enable numbers to be relative

    -- completion menu settings
    opt.completeopt = "menuone,noselect" -- completion behaviour
    opt.omnifunc = "v:lua.vim.lsp.omnifunc" -- completion omnifunc

    -- Set so that folders are index for find command
    opt.path:append({"**/*"})
    opt.wildignore:append({"node_modules", ".git", "dist", ".next"})

    g.mapleader = " " -- space leader

    -- Tag Jump
    b.match_words = table.concat({"(:),\\[:\\],{:},<:>,", "<\\@<=\\([^/][^ \t>]*\\)[^>]*\\%(>\\|$\\):<\\@<=/\1>"})

    opt.hidden = true -- buffer hidden
    opt.ignorecase = true -- case sens ignore search
    opt.splitbelow = true -- split behavior
    opt.splitright = true -- split behavior
    go.termguicolors = true -- colors tmux settings
    go.t_Co = "256" -- colors tmux setting
    go.t_ut = "" -- colors tmux setting
    -- opt.background = "dark" -- dark
    opt.numberwidth = 2 -- width on numbeer row

    opt.mouse = "a" -- mouse on don't use mouse lol

    opt.signcolumn = "auto" -- 2 sign column
    opt.cmdheight = 1 -- ex cmd height
    opt.guifont = "Hack Nerd Font Mono:h12" -- set font
    opt.showcmd = false -- disable showcmd

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
