-- vim test settings
require "nvim_utils"

local TESTING_STATUS = "Test"

T = {}

T.TestStarted = function()
    TESTING_STATUS = "Test ⌛  "
end

T.TestFinished = function()
    local context = vim.api.nvim_get_var("neomake_hook_context")
    if context.jobinfo.exit_code == 0 then
        TESTING_STATUS = "Test ✅  "
    else
        TESTING_STATUS = "Test ❌  "
    end
end

T.TestStatus = function()
    return TESTING_STATUS
end

vim.api.nvim_set_var("test#javascript#runnter", "jest")
vim.api.nvim_set_var("test#javascript#jest#options", "--reporters ~/.dotfiles-darwin/vim-qf-format.js")
vim.api.nvim_set_var("test#strategy", "neomake")

local autocmds = {
    neomake_hook = {
        {"User", "NeomakeJobFinished", "lua T.TestFinished()"},
        {"User", "NeomakeJobStarted", "lua T.TestStarted()"}
    }
}

nvim_create_augroups(autocmds)

return T
