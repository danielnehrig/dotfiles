local Func = require("core.func")

local definitions = {
    ft = {
        {"FileType", "dashboard", "set showtabline=0"},
        {"BufNewFile,BufRead", "*", "set showtabline=2"},
        {"BufNewFile,BufRead", "*.toml", " setf toml"}
    }
}

Func.nvim_create_augroups(definitions)
