local function attach()
    print("attaching")
    if not packer_plugins["nvim-dap"].loaded then
        vim.cmd [[packadd nvim-dap]]
        vim.cmd [[packadd nvim-dap-ui]]
    end
    require("plugins.dap")
    local dap = require "dap"
    dap.run(
        {
            type = "node2",
            request = "attach",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = {"<node_internals>/**/*.ts"}
        }
    )
end

return {
    attach = attach
}
