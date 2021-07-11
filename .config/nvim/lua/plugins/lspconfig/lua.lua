local globals = require("core.global")
local sumneko_root_path = os.getenv("HOME") .. "/dotfiles/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. globals.os_name .. "/lua-language-server"
local custom_attach = require("plugins.lspconfig").custom_attach
local lspconfig = require("lspconfig")

-- Lua Settings for nvim config and plugin development
local luadev =
    require("lua-dev").setup(
    {
        lspconfig = {
            on_attach = custom_attach,
            cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"}
        }
    }
)

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = luadev.settings,
  root_dir = require("lspconfig/util").root_pattern("."),
  on_attach = function(client, bufnr)
    custom_attach(client, bufnr)
  end
}
