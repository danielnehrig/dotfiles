local gl = require("galaxyline")
local TestStatus = require("testing").TestStatus
gl.short_line_list = { }

local colors = {
    bg = "#282c34",
    line_bg = "#282c34",
    fg = "#D8DEE9",
    fg_green = "#65a380",
    yellow = "#A3BE8C",
    cyan = "#22262C",
    darkblue = "#61afef",
    green = "#BBE67E",
    orange = "#FF8800",
    purple = "#252930",
    magenta = "#c678dd",
    blue = "#61afef",
    red = "#DF8890",
    lightbg = "#3C4048",
    nord = "#81A1C1",
    greenYel = "#EBCB8B"
}

local function default_line()
    local gls = gl.section
    gls.left[1] = {
        leftRounded = {
            provider = function()
                return ""
            end,
            highlight = {colors.nord, colors.bg}
        }
    }

    gls.left[2] = {
        ViMode = {
            provider = function()
                local alias = {
                    n = " NORMAL ",
                    i = " INSERT ",
                    c = " COMMAND ",
                    V = " VISUAL ",
                    [""] = " VISUAL ",
                    v = " VISUAL ",
                    R = " REPLACE "
                }
                return alias[vim.fn.mode()]
            end,
            highlight = {colors.bg, colors.nord},
            separator = " ",
            separator_highlight = {colors.lightbg, colors.lightbg}
        }
    }

    gls.left[3] = {
        FileIcon = {
            provider = "FileIcon",
            condition = buffer_not_empty,
            highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
        }
    }

    gls.left[4] = {
        FileName = {
            provider = {"FileName", "GitBranch", "FileSize"},
            condition = buffer_not_empty,
            highlight = {colors.fg, colors.lightbg}
        }
    }

    gls.left[5] = {
        teech = {
            provider = function()
                return ""
            end,
            separator = "",
            highlight = {colors.lightbg, colors.bg}
        }
    }

    local checkwidth = function()
        local squeeze_width = vim.fn.winwidth(0) / 2
        if squeeze_width > 40 then
            return true
        end
        return false
    end

    gls.left[6] = {
        DiffAdd = {
            provider = "DiffAdd",
            condition = checkwidth,
            icon = "   ",
            highlight = {colors.greenYel, colors.line_bg}
        }
    }

    gls.left[7] = {
        DiffModified = {
            provider = "DiffModified",
            condition = checkwidth,
            icon = " ",
            highlight = {colors.orange, colors.line_bg}
        }
    }

    gls.left[8] = {
        DiffRemove = {
            provider = "DiffRemove",
            condition = checkwidth,
            icon = " ",
            highlight = {colors.red, colors.line_bg}
        }
    }

    gls.left[9] = {
        LeftEnd = {
            provider = function()
                return " "
            end,
            separator = " ",
            separator_highlight = {colors.line_bg, colors.line_bg},
            highlight = {colors.line_bg, colors.line_bg}
        }
    }

    gls.left[10] = {
        DiagnosticError = {
            provider = "DiagnosticError",
            icon = "  ",
            highlight = {colors.red, colors.bg}
        }
    }

    gls.left[11] = {
        Space = {
            provider = function()
                return " "
            end,
            highlight = {colors.line_bg, colors.line_bg}
        }
    }

    gls.left[12] = {
        DiagnosticWarn = {
            provider = "DiagnosticWarn",
            icon = "  ",
            highlight = {colors.blue, colors.bg}
        }
    }


    gls.left[13] = {
        LspStatus = {
            provider = function()
                return require('lsp-status').status()
            end,
            icon = "",
            highlight = {colors.green, colors.bg}
        }
    }

    gls.right[1] = {
        testing_status = {
            provider = function()
                return TestStatus()
            end,
            separator = " ",
            separator_highlight = {colors.bg, colors.bg},
            highlight = {colors.red, colors.bg}
        }
    }

    gls.right[4] = {
        right_LeftRounded = {
            provider = function()
                return ""
            end,
            highlight = {colors.fg, colors.bg}
        }
    }

    gls.right[6] = {
        PerCent = {
            provider = "LinePercent",
            separator = " ",
            separator_highlight = {colors.fg, colors.fg},
            highlight = {colors.bg, colors.fg}
        }
    }

    gls.right[7] = {
        rightRounded = {
            provider = function()
                return ""
            end,
            highlight = {colors.fg, colors.bg}
        }
    }
end

default_line()

return colors
