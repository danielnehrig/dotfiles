local TestStatus = require("plugins.testing").TestStatus

local function evilline()
    local gl = require("galaxyline")
    local colors = require("galaxyline.theme").default
    local gls = gl.section
    gl.short_line_list = {}
    local condition = require("galaxyline.condition")
    gl.short_line_list = {"NvimTree", "vista", "dbui", "packer"}
    gls.left = {}
    gls.mid = {}
    gls.right = {}
    gls.short_line_left = {}

    table.insert(
        gls.left,
        {
            RainbowRed = {
                provider = function()
                    return "▊ "
                end,
                highlight = {colors.blue, colors.bg}
            }
        }
    )

    table.insert(
        gls.left,
        {
            ViMode = {
                provider = function()
                    -- auto change color according the vim mode
                    local mode_color = {
                        n = colors.red,
                        i = colors.green,
                        v = colors.blue,
                        [""] = colors.blue,
                        V = colors.blue,
                        c = colors.magenta,
                        no = colors.red,
                        s = colors.orange,
                        S = colors.orange,
                        [""] = colors.orange,
                        ic = colors.yellow,
                        R = colors.violet,
                        Rv = colors.violet,
                        cv = colors.red,
                        ce = colors.red,
                        r = colors.cyan,
                        rm = colors.cyan,
                        ["r?"] = colors.cyan,
                        ["!"] = colors.red,
                        t = colors.red
                    }
                    vim.api.nvim_command(
                        "hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg
                    )
                    return "  "
                end
            }
        }
    )

    table.insert(
        gls.left,
        {
            FileSize = {
                provider = "FileSize",
                condition = condition.buffer_not_empty,
                highlight = {colors.fg, colors.bg}
            }
        }
    )

    table.insert(
        gls.left,
        {
            FileIcon = {
                provider = "FileIcon",
                condition = condition.buffer_not_empty,
                highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
            }
        }
    )

    table.insert(
        gls.left,
        {
            FileName = {
                provider = "FileName",
                condition = condition.buffer_not_empty,
                highlight = {colors.fg, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.left,
        {
            LineInfo = {
                provider = "LineColumn",
                separator = " ",
                separator_highlight = {"NONE", colors.bg},
                highlight = {colors.fg, colors.bg}
            }
        }
    )

    table.insert(
        gls.left,
        {
            PerCent = {
                provider = "LinePercent",
                separator = " ",
                separator_highlight = {"NONE", colors.bg},
                highlight = {colors.fg, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.left,
        {
            DiagnosticError = {
                provider = "DiagnosticError",
                icon = "  ",
                highlight = {colors.red, colors.bg}
            }
        }
    )

    table.insert(
        gls.left,
        {
            DiagnosticWarn = {
                provider = "DiagnosticWarn",
                icon = "  ",
                highlight = {colors.yellow, colors.bg}
            }
        }
    )

    table.insert(
        gls.left,
        {
            DiagnosticHint = {
                provider = "DiagnosticHint",
                icon = "  ",
                highlight = {colors.cyan, colors.bg}
            }
        }
    )

    table.insert(
        gls.left,
        {
            DiagnosticInfo = {
                provider = "DiagnosticInfo",
                icon = "  ",
                highlight = {colors.blue, colors.bg}
            }
        }
    )

    table.insert(
        gls.mid,
        {
            ShowLspClient = {
                provider = "GetLspClient",
                condition = function()
                    local tbl = {["dashboard"] = true, [""] = true}
                    if tbl[vim.bo.filetype] then
                        return false
                    end
                    return true
                end,
                icon = " LSP:",
                highlight = {colors.yellow, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.right,
        {
            ShowLspStatus = {
                provider = function()
                    return require("lsp-status").status()
                end,
                icon = "Status:",
                separator = " ",
                highlight = {colors.yellow, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.right,
        {
            FileEncode = {
                provider = "FileEncode",
                condition = condition.hide_in_width,
                highlight = {colors.green, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.right,
        {
            FileFormat = {
                provider = "FileFormat",
                condition = condition.hide_in_width,
                separator = " ",
                separator_highlight = {"NONE", colors.bg},
                highlight = {colors.green, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.right,
        {
            GitIcon = {
                provider = function()
                    return "   "
                end,
                condition = condition.check_git_workspace,
                highlight = {colors.violet, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.right,
        {
            GitBranch = {
                provider = "GitBranch",
                separator = " ",
                condition = condition.check_git_workspace,
                highlight = {colors.violet, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.right,
        {
            DiffAdd = {
                provider = "DiffAdd",
                condition = condition.hide_in_width,
                icon = " ",
                separator_highlight = {colors.bg, colors.bg},
                highlight = {colors.green, colors.bg}
            }
        }
    )

    table.insert(
        gls.right,
        {
            DiffModified = {
                provider = "DiffModified",
                condition = condition.hide_in_width,
                icon = "柳",
                separator = "",
                highlight = {colors.orange, colors.bg}
            }
        }
    )

    table.insert(
        gls.right,
        {
            DiffRemove = {
                provider = "DiffRemove",
                condition = condition.hide_in_width,
                icon = " ",
                highlight = {colors.red, colors.bg}
            }
        }
    )

    table.insert(
        gls.right,
        {
            testing_status = {
                provider = function()
                    return TestStatus()
                end,
                separator = "",
                separator_highlight = {colors.bg, colors.bg},
                highlight = {colors.fg, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.right,
        {
            RainbowBlue = {
                provider = function()
                    return "  ▊"
                end,
                separator = "",
                separator_highlight = {"NONE", colors.bg},
                highlight = {colors.blue, colors.bg}
            }
        }
    )

    -- shortline
    table.insert(
        gls.short_line_left,
        {
            BufferType = {
                provider = "FileTypeName",
                separator = " ",
                separator_highlight = {"NONE", colors.bg},
                highlight = {colors.blue, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.short_line_left,
        {
            SFileName = {
                provider = "SFileName",
                condition = condition.buffer_not_empty,
                highlight = {colors.fg, colors.bg, "bold"}
            }
        }
    )

    table.insert(
        gls.short_line_left,
        {
            BufferIcon = {
                provider = "BufferIcon",
                highlight = {colors.fg, colors.bg}
            }
        }
    )
end

evilline()
