local function addPlug()
    if not packer_plugins["nvim-dap"].loaded then
        vim.cmd [[packadd nvim-dap]]
        vim.cmd [[packadd nvim-dap-ui]]
    end
    require("plugins.dap")
end

local function attach()
    print("attaching")
    addPlug()
    local dap = require "dap"
    dap.continue()
end

return {
    attach = attach,
    addPlug = addPlug
}
