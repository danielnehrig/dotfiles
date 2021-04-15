local gl = require("galaxyline")
local TestStatus = require("plugins.testing").TestStatus
  local gls = gl.section
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

local function evilline()
    local colors = require('galaxyline.theme').default
    local condition = require('galaxyline.condition')
    gl.short_line_list = {'NvimTree','vista','dbui','packer'}

    gls.left[1] = {
        RainbowRed = {
            provider = function() return '▊ ' end,
            highlight = {colors.blue,colors.bg}
        },
    }
    gls.left[2] = {
        ViMode = {
            provider = function()
                -- auto change color according the vim mode
                local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                    [''] = colors.blue,V=colors.blue,
                    c = colors.magenta,no = colors.red,s = colors.orange,
                    S=colors.orange,[''] = colors.orange,
                    ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                    cv = colors.red,ce=colors.red, r = colors.cyan,
                    rm = colors.cyan, ['r?'] = colors.cyan,
                ['!']  = colors.red,t = colors.red}
                vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()] ..' guibg='..colors.bg)
                return '  '
            end,
        },
    }
    gls.left[3] = {
        FileSize = {
            provider = 'FileSize',
            condition = condition.buffer_not_empty,
            highlight = {colors.fg,colors.bg}
        }
    }
    gls.left[4] ={
        FileIcon = {
            provider = 'FileIcon',
            condition = condition.buffer_not_empty,
            highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
        },
    }

    gls.left[5] = {
        FileName = {
            provider = 'FileName',
            condition = condition.buffer_not_empty,
            highlight = {colors.fg,colors.bg,'bold'}
        }
    }

    gls.left[6] = {
        LineInfo = {
            provider = 'LineColumn',
            separator = ' ',
            separator_highlight = {'NONE',colors.bg},
            highlight = {colors.fg,colors.bg},
        },
    }

    gls.left[7] = {
        PerCent = {
            provider = 'LinePercent',
            separator = ' ',
            separator_highlight = {'NONE',colors.bg},
            highlight = {colors.fg,colors.bg,'bold'},
        }
    }

    gls.left[8] = {
        DiagnosticError = {
            provider = 'DiagnosticError',
            icon = '  ',
            highlight = {colors.red,colors.bg}
        }
    }
    gls.left[9] = {
        DiagnosticWarn = {
            provider = 'DiagnosticWarn',
            icon = '  ',
            highlight = {colors.yellow,colors.bg},
        }
    }

    gls.left[10] = {
        DiagnosticHint = {
            provider = 'DiagnosticHint',
            icon = '  ',
            highlight = {colors.cyan,colors.bg},
        }
    }

    gls.left[11] = {
        DiagnosticInfo = {
            provider = 'DiagnosticInfo',
            icon = '  ',
            highlight = {colors.blue,colors.bg},
        }
    }

    gls.mid[1] = {
        ShowLspClient = {
            provider = 'GetLspClient',
            condition = function ()
                local tbl = {['dashboard'] = true,['']=true}
                if tbl[vim.bo.filetype] then
                    return false
                end
                return true
            end,
            icon = ' LSP:',
            highlight = {colors.yellow,colors.bg,'bold'}
        }
    }

    gls.right[1] = {
        FileEncode = {
            provider = 'FileEncode',
            condition = condition.hide_in_width,
            separator = ' ',
            separator_highlight = {'NONE',colors.bg},
            highlight = {colors.green,colors.bg,'bold'}
        }
    }

    gls.right[2] = {
        FileFormat = {
            provider = 'FileFormat',
            condition = condition.hide_in_width,
            separator = ' ',
            separator_highlight = {'NONE',colors.bg},
            highlight = {colors.green,colors.bg,'bold'}
        }
    }

    gls.right[3] = {
        GitIcon = {
            provider = function() return '  ' end,
            condition = condition.check_git_workspace,
            separator = ' ',
            separator_highlight = {'NONE',colors.bg},
            highlight = {colors.violet,colors.bg,'bold'},
        }
    }

    gls.right[4] = {
        GitBranch = {
            provider = 'GitBranch',
            condition = condition.check_git_workspace,
            highlight = {colors.violet,colors.bg,'bold'},
        }
    }

    gls.right[5] = {
        DiffAdd = {
            provider = 'DiffAdd',
            condition = condition.hide_in_width,
            icon = '  ',
            highlight = {colors.green,colors.bg},
        }
    }
    gls.right[6] = {
        DiffModified = {
            provider = 'DiffModified',
            condition = condition.hide_in_width,
            icon = ' 柳',
            highlight = {colors.orange,colors.bg},
        }
    }
    gls.right[7] = {
        DiffRemove = {
            provider = 'DiffRemove',
            condition = condition.hide_in_width,
            icon = '  ',
            highlight = {colors.red,colors.bg},
        }
    }

    gls.right[8] = {
        testing_status = {
            provider = function()
                return TestStatus()
            end,
            separator = " ",
            separator_highlight = {colors.bg, colors.bg},
            highlight = {colors.fg,colors.bg,'bold'}
        }
    }

    gls.right[9] = {
        RainbowBlue = {
            provider = function() return ' ▊' end,
            highlight = {colors.blue,colors.bg}
        },
    }

    gls.short_line_left[1] = {
        BufferType = {
            provider = 'FileTypeName',
            separator = ' ',
            separator_highlight = {'NONE',colors.bg},
            highlight = {colors.blue,colors.bg,'bold'}
        }
    }

    gls.short_line_left[2] = {
        SFileName = {
            provider =  'SFileName',
            condition = condition.buffer_not_empty,
            highlight = {colors.fg,colors.bg,'bold'}
        }
    }


    gls.short_line_right[1] = {
        BufferIcon = {
            provider= 'BufferIcon',
            highlight = {colors.fg,colors.bg}
        }
    }
end

evilline()

return colors
