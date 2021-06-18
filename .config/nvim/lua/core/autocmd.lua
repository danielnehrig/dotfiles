local Func = require("utils")

local definitions = {
    ft = {
        {"FileType", "dashboard", "set showtabline=0"}, -- disable tabline in dashboard
        {"BufNewFile,BufRead", "*", "set showtabline=2"}, -- renable it
        {"BufNewFile,BufRead", "*", "set number"}, -- set number
        {"BufNewFile,BufRead", "*", "set relativenumber"}, -- set relativenumber
        {"TermOpen", "*", "set number!"},
        {"TermOpen", "*", "set relativenumber!"},
        {"TermOpen", "*", "set showtabline=2"}, -- renable it
        {"BufNewFile,BufRead", "*.toml", " setf toml"} -- set toml filetype
    }
}

Func.nvim_create_augroups(definitions)
