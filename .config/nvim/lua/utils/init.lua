local M = {}

function M.map(bufnr, type, key, value)
    vim.api.nvim_buf_set_keymap(bufnr, type, key, value, {noremap = true, silent = true})
end

function M.autocmd(event, triggers, operations)
    local cmd = string.format("autocmd %s %s %s", event, triggers, operations)
    vim.cmd(cmd)
end

return M
