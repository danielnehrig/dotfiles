local gl = require("galaxyline")
local gls = gl.section
local TestStatus = require("plugins.testing").TestStatus

gl.short_line_list = {
    "LuaTree",
    "vista",
    "dbui",
    "startify",
    "term",
    "nerdtree",
    "NvimTree",
    "packer",
    "fugitive",
    "fugitiveblame",
    "plug"
}

local colors = {
    bg = "#282c34",
    line_bg = "#353644",
    fg = "#8FBCBB",
    fg_green = "#65a380",
    yellow = "#fabd2f",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#afd700",
    orange = "#FF8800",
    purple = "#5d4d7a",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67"
}

local function trailing_whitespace()
    local trail = vim.fn.search("\\s$", "nw")
    if trail ~= 0 then
        return " "
    else
        return nil
    end
end

TrailingWhiteSpace = trailing_whitespace

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
    end
    return false
end

local function has_file_type()
    local f_type = vim.bo.filetype
    if not f_type or f_type == "" then
        return false
    end
    return true
end

gls.left[1] = {
    FirstElement = {
        provider = function()
            return " "
        end,
        highlight = {colors.blue, colors.line_bg}
    }
}
gls.left[2] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local alias = {
                n = "NORMAL",
                i = "INSERT",
                c = "COMMAND",
                V = "VISUAL",
                [""] = "VISUAL",
                v = "VISUAL",
                cl = "COMMAND-LINE",
                ["r?"] = ":CONFIRM",
                rm = "--MORE",
                R = "REPLACE",
                Rv = "VIRTUAL",
                s = "SELECT",
                S = "SELECT",
                ["r"] = "HIT-ENTER",
                [""] = "SELECT",
                t = "TERMINAL",
                ["!"] = "SHELL"
            }
            local mode_color = {
                n = colors.green,
                i = colors.blue,
                v = colors.magenta,
                [""] = colors.blue,
                V = colors.blue,
                c = colors.red,
                no = colors.magenta,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.purple,
                Rv = colors.purple,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.green,
                t = colors.green,
                cl = colors.purple,
                ["rl?"] = colors.red,
                ["rl"] = colors.red,
                rml = colors.red,
                Rl = colors.yellow,
                Rvl = colors.magenta
            }
            local vim_mode = vim.fn.mode()
            vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim_mode])
            return alias[vim_mode] .. "   "
        end,
        highlight = {colors.red, colors.line_bg, "bold"}
    }
}
gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.line_bg}
    }
}
gls.left[4] = {
    FileName = {
        provider = {"FileName", "FileSize"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.line_bg, "bold"}
    }
}

gls.left[5] = {
    GitIcon = {
        provider = function()
            return "  "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.orange, colors.line_bg}
    }
}
gls.left[6] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {"#8FBCBB", colors.line_bg, "bold"}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[7] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.green, colors.line_bg}
    }
}
gls.left[8] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}
gls.left[9] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}
gls.left[10] = {
    LeftEnd = {
        provider = function()
            return ""
        end,
        separator = "",
        separator_highlight = {colors.bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[11] = {
    TrailingWhiteSpace = {
        provider = TrailingWhiteSpace,
        icon = "  ",
        highlight = {colors.yellow, colors.bg}
    }
}

gls.left[12] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[14] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.bg}
    }
}

gls.left[15] = {
    LspStatus = {
        provider = function()
            return require("lsp-status").status()
        end,
        highlight = {colors.green, colors.bg},
        icon = "  λ "
    }
}

gls.right[1] = {
    FileFormat = {
        provider = "FileFormat",
        separator = " ",
        separator_highlight = {colors.bg, colors.line_bg},
        highlight = {colors.fg, colors.line_bg, "bold"}
    }
}
gls.right[3] = {
    Test = {
        provider = function()
            return "  | " .. TestStatus()
        end,
        highlight = {colors.fg, colors.line_bg}
    }
}
gls.right[4] = {
    LineInfo = {
        provider = "LineColumn",
        separator = " | ",
        separator_highlight = {colors.blue, colors.line_bg},
        highlight = {colors.fg, colors.line_bg}
    }
}
gls.right[5] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.cyan, colors.darkblue, "bold"}
    }
}

-- gls.right[4] = {
--   ScrollBar = {
--     provider = 'ScrollBar',
--     highlight = {colors.blue,colors.purple},
--   }
-- }
--
-- gls.right[3] = {
--   Vista = {
--     provider = VistaPlugin,
--     separator = ' ',
--     separator_highlight = {colors.bg,colors.line_bg},
--     highlight = {colors.fg,colors.line_bg,'bold'},
--   }
-- }

gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = "",
        condition = has_file_type,
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.fg, colors.purple}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = "BufferIcon",
        separator = "",
        condition = has_file_type,
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.fg, colors.purple}
    }
}
