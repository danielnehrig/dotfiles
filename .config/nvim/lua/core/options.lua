local global = require('core.global')
local M = require('utils')
local cmd = vim.cmd

local function bind_option(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.cmd('set ' .. k)
    else
      vim.cmd('set ' .. k .. '=' .. v)
    end
  end
end

local function load_options()
  cmd("set relativenumber")
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

  M.opt("w", "signcolumn", "yes")
  M.opt("o", "cmdheight", 1)

  M.opt("o", "updatetime", 300) -- update interval for gitsigns 
  M.opt("o", "clipboard", "unnamedplus")

  -- for indenline
  M.opt("b", "expandtab", true )
  M.opt("b", "shiftwidth", 2 )
end

load_options()
