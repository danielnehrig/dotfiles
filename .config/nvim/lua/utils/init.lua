local scopes = {o = vim.o, b = vim.bo, w = vim.wo, g = vim.g}

local M = {}

function M.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

function M.map(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true})
end

function M.autocmd(event, triggers, operations)
    local cmd = string.format("autocmd %s %s %s", event, triggers, operations)
    vim.cmd(cmd)
end

function M.clear_cache()
    -- clear core config namespace
    for k, v in pairs(package.loaded) do
        if string.match(k, "^core") then
            package.loaded[k] = nil
        end
    end
    -- clear plugins config namespace
    for k, v in pairs(package.loaded) do
        if string.match(k, "^utils") then
            package.loaded[k] = nil
        end
    end
    -- clear plugins config namespace
    for k, v in pairs(package.loaded) do
        if string.match(k, "^plugins") then
            package.loaded[k] = nil
        end
    end

    vim.cmd("luafile ~/.config/nvim/lua/main.lua")
end

return M
