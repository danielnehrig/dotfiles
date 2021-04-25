local map = require "utils".map
local autocmd = require "utils".autocmd
local lsp_status = require("lsp-status")
local lspconfig = require("lspconfig")
local cmd = vim.cmd
local fn = vim.fn
local setOption = vim.api.nvim_set_option
local saga = require("lspsaga")

setOption("omnifunc", "v:lua.vim.lsp.omnifunc")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits"
    }
}

-- compe setup
require("compe").setup(
    {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = "enable",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        source = {
            path = true,
            buffer = true,
            calc = true,
            vsnip = true,
            nvim_lsp = true,
            nvim_lua = true,
            spell = false,
            tags = false,
            snippets_nvim = true,
            treesitter = true
        }
    }
)

cmd [[set completeopt=menuone,noinsert,noselect]]

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.cmd [[noautocmd :update]]
        end
    end
end

FormatToggle = function(value)
    vim.g[string.format("format_disabled_%s", vim.bo.filetype)] = value
end
vim.cmd [[command! FormatDisable lua FormatToggle(true)]]
vim.cmd [[command! FormatEnable lua FormatToggle(false)]]

_G.formatting = function()
    if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
        vim.lsp.buf.formatting(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {})
    end
end

saga.init_lsp_saga()
lsp_status.register_progress()
-- custom attach config
local custom_attach = function(client, bufnr)
    lsp_status.on_attach(client)

    map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    map(bufnr, "n", "<space>gd", '<cmd>lua require("lspsaga.provider").preview_definition()<CR>')
    map(bufnr, "n", "K", '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
    map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    map(bufnr, "n", "<space>gr", "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>")
    map(bufnr, "n", "gs", '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
    map(bufnr, "i", "<C-g>", '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>')
    map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    map(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    map(bufnr, "n", "<space>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    map(bufnr, "n", "<space>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    map(bufnr, "n", "<space>ah", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map(bufnr, "n", "<space>af", '<cmd>lua require("lspsaga.codeaction").code_action()<CR>')
    map(bufnr, "v", "<space>ac", '<cmd>lua require("lspsaga.codeaction").range_code_action()<CR>')
    map(bufnr, "n", "<space>ee", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>")
    map(bufnr, "n", "<space>ar", '<cmd>lua require("lspsaga.rename").rename()<CR>')
    map(bufnr, "n", "gh", '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>')
    map(bufnr, "n", "<space>=", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    map(bufnr, "n", "<space>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    map(bufnr, "n", "<space>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
    map(bufnr, "i", "<C-space>", "<cmd>call compe#complete()<CR>")
    map(bufnr, "i", "<TAB>", "<cmd>call compe#confirm()<CR>")
    map(bufnr, "n", "<space>cd", '<cmd>lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>')

    autocmd("CursorHold", "<buffer>", "lua require'lspsaga.diagnostic'.show_line_diagnostics()")

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
    fn.sign_define("LspDiagnosticsSignError", {text = ""})
    fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
    fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
    fn.sign_define("LspDiagnosticsSignHint", {text = ""})
end

-- lsp setups
lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup {
            disable_commands = false,
            enable_import_on_completion = true,
            import_on_completion_timeout = 5000,
            -- eslint
            eslint_bin = "eslint_d",
            eslint_args = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
            eslint_enable_disable_comments = true,
            eslint_enable_diagnostics = false,
            eslint_diagnostics_debounce = 250,
            -- formatting
            enable_formatting = false,
            formatter = "prettier_d",
            formatter_args = {"--stdin-filepath", "$FILENAME"},
            format_on_save = false,
            no_save_after_format = false
        }
        vim.lsp.buf_request = ts_utils.buf_request
        if client.config.flags then
            client.config.flags.allow_incremental_sync = true
        end
        client.resolved_capabilities.document_formatting = false

        custom_attach(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>gi", ":TSLspImportAll<CR>", {silent = true})
    end,
    capabilities = capabilities
}

lspconfig.cssls.setup {on_attach = custom_attach}
lspconfig.html.setup {on_attach = custom_attach}
lspconfig.rust_analyzer.setup {
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd [[augroup Format]]
            vim.cmd [[autocmd! * <buffer>]]
            vim.cmd [[autocmd BufWritePost <buffer> RustFmt]]
            vim.cmd [[augroup END]]
        end

        custom_attach(client)
    end,
    capabilities = capabilities
}
lspconfig.gopls.setup {on_attach = custom_attach}
lspconfig.pyright.setup {on_attach = custom_attach}
lspconfig.dockerls.setup {on_attach = custom_attach}
lspconfig.clangd.setup {on_attach = custom_attach}
lspconfig.vimls.setup {on_attach = custom_attach}

local eslint = require("plugins.efm.eslint")
local prettier = require("plugins.efm.prettier")
local luafmt = require("plugins.efm.luafmt")

lspconfig.efm.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        if client.resolved_capabilities.document_formatting then
            vim.cmd [[augroup Format]]
            vim.cmd [[autocmd! * <buffer>]]
            vim.cmd [[autocmd BufWritePost <buffer> lua formatting()]]
            vim.cmd [[augroup END]]
        end

        custom_attach(client)
    end,
    root_dir = function()
        return vim.fn.getcwd()
    end,
    init_options = {
        documentFormatting = false,
        codeAction = true
    },
    settings = {
        -- lintDebounce = 200,
        languages = {
            javascript = {eslint},
            javascriptreact = {eslint},
            ["javascript.jsx"] = {eslint},
            typescript = {eslint},
            typescriptreact = {prettier, eslint},
            ["typescript.tsx"] = {eslint},
            lua = {luafmt}
        }
    },
    filetypes = {
        "lua",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false
    }
)

-- lua sumenko
local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has("win32") == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = os.getenv("HOME") .. "/.dotfiles-darwin/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local function get_lua_runtime()
    local result = {}
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. "/lua/"
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end
    result[vim.fn.expand("$VIMRUNTIME/lua")] = true
    result[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true

    return result
end

require "lspconfig".sumneko_lua.setup {
    on_attach = custom_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";")
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = get_lua_runtime(),
                maxPreload = 1000,
                preloadFileSize = 1000
            }
        }
    }
}
