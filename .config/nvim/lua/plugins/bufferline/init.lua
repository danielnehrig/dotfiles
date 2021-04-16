vim.o.termguicolors = true
local opt = {silent = true}
local g = vim.g
local bufferline_exists = pcall(vim.cmd, [[packadd nvim.bufferline.lua]])

g.mapleader = " "
vim.api.nvim_set_keymap("n", "<Leader>tp", [[<Cmd>BufferPrevious<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>tn", [[<Cmd>BufferNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>t1", [[<Cmd>BufferGoto 1<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>t2", [[<Cmd>BufferGoto 2<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>t3", [[<Cmd>BufferGoto 3<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>t4", [[<Cmd>BufferGoto 4<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>t5", [[<Cmd>BufferGoto 5<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>t6", [[<Cmd>BufferGoto 6<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>t6", [[<Cmd>BufferGoto 6<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>tc", [[<Cmd>BufferClose<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>tt", [[<Cmd>BufferPick<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>ta", [[<Cmd>BufferCloseAllButCurrent<CR>]], opt)

-- colors for active , inactive buffer tabs
if bufferline_exists then
    require "bufferline".setup {
        options = {
            buffer_close_icon = "",
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 18,
            enforce_regular_tabs = true,
            view = "multiwindow",
            show_buffer_close_icons = true,
            separator_style = "thin"
        },
        highlights = {
            background = {
                guifg = comment_fg,
                guibg = "#282c34"
            },
            fill = {
                guifg = comment_fg,
                guibg = "#282c34"
            },
            buffer_selected = {
                guifg = normal_fg,
                guibg = "#3A3E44",
                gui = "bold"
            },
            separator_visible = {
                guifg = "#282c34",
                guibg = "#282c34"
            },
            separator_selected = {
                guifg = "#282c34",
                guibg = "#282c34"
            },
            separator = {
                guifg = "#282c34",
                guibg = "#282c34"
            },
            indicator_selected = {
                guifg = "#282c34",
                guibg = "#282c34"
            },
            modified_selected = {
                guifg = string_fg,
                guibg = "#3A3E44"
            }
        }
    }

    g.mapleader = " "
    -- tabnew and tabprev
    vim.api.nvim_set_keymap("n", "<Leader>tn", [[<Cmd>BufferLineCycleNext<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>tp", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
end
