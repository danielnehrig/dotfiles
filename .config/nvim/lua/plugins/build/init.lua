local Func = require("core.func")

vim.g.neomake_open_list = 2

vim.api.nvim_set_var("test#javascript#runnter", "jest")
vim.api.nvim_set_var("test#javascript#jest#options", "--reporters ~/.dotfiles-darwin/vim-qf-format.js")
vim.api.nvim_set_var("test#strategy", "neomake")

local function Make(super)
    local T = {}
    T.__index = T
    T.make_status = "Make"
    T.success = false
    T.failed = false
    setmetatable(T, super)

    function T.new(...)
        if T._instance then
            return T._instance
        end

        local instance = setmetatable({}, T)
        if instance.ctor then
            instance:ctor(...)
        end

        return T._instance
    end

    function T.MakeFinished()
        local context = vim.api.nvim_get_var("neomake_hook_context")
        if context.jobinfo.exit_code == 0 then
            T.make_status = "Make ✅ "
            T.failed = false
            T.success = true
        else
            T.failed = true
            T.success = false
            T.make_status = "Make ❌ "
        end
    end

    function T.MakeStarted()
        T.make_status = "Make ⌛ "
        T.failed = false
        T.success = false
        T.running = true
    end

    function T.MakeStatus()
        return T.make_status
    end

    function T.GetFailed()
        return T.failed
    end

    function T.GetSuccess()
        return T.success
    end

    return T
end

local make = Make()

local autocmds = {
    neomake_hook = {
        {"User", "NeomakeJobFinished", "lua require('plugins.build').MakeFinished()"},
        {"User", "NeomakeJobStarted", "lua require('plugins.build').MakeStarted()"}
    }
}

Func.nvim_create_augroups(autocmds)

return make
