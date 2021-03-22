-- vim test settings

local TESTING_STATUS = "Test ?  "
local T = {}

T.TestStarted = function()
    TESTING_STATUS = "Test ⌛  "
end

T.TestFinished = function()
    TESTING_STATUS = "Test ✅  "
    TESTING_STATUS = "Test ❌  "
end

T.TestStatus = function()
    return TESTING_STATUS
end

vim.api.nvim_set_var("test#javascript#runnter", "jest")
vim.api.nvim_set_var("test#javascript#jest#options", "--reporters jest-vim-reporter")
vim.api.nvim_set_var("test#strategy", "neomake")

return T
