local Func = require("utils")

local definitions = {
    ft = {
        {"FileType", "dashboard", "set showtabline=0"}, -- disable tabline in dashboard
        {"BufNewFile,BufRead", "*", "set showtabline=2"}, -- renable it
        {"BufNewFile,BufRead", "*.toml", " setf toml"} -- set toml filetype
    }
}

Func.nvim_create_augroups(definitions)
