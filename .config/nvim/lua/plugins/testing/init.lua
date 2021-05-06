local Func = require("core.func")

vim.g.neomake_open_list = 2

local MAKE_STATUS = "Make"

T = {}

T.MakeStarted = function()
    MAKE_STATUS = "Make ⌛ "
end

T.MakeFinished = function()
    local context = vim.api.nvim_get_var("neomake_hook_context")
    if context.jobinfo.exit_code == 0 then
        MAKE_STATUS = "Make ✅ "
    else
        MAKE_STATUS = "Make ❌ "
    end
end

T.MakeStatus = function()
    return MAKE_STATUS
end

vim.api.nvim_set_var("test#javascript#runnter", "jest")
vim.api.nvim_set_var("test#javascript#jest#options", "--reporters ~/.dotfiles-darwin/vim-qf-format.js")
vim.api.nvim_set_var("test#strategy", "neomake")

local autocmds = {
    neomake_hook = {
        {"User", "NeomakeJobFinished", "lua T.MakeFinished()"},
        {"User", "NeomakeJobStarted", "lua T.MakeStarted()"}
    }
}

Func.nvim_create_augroups(autocmds)

return T
