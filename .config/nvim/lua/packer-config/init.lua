local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd
local global = require("core.global")
local data_path = global.data_path
local packer_compiled = data_path .. "packer_compiled.vim"
local compile_to_lua = data_path .. "lua" .. global.path_sep .. "_compiled.lua"

-- bootstrap packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

local packer = nil
local function init()
    if not packer then
        vim.api.nvim_command("packadd packer.nvim")
        packer = require("packer")
    end
    print(packer_compiled)
    packer.init(
        {
            compile_path = packer_compiled,
            disable_commands = true,
            git = {clone_timeout = 120}
        }
    )
    packer.reset()
    local use = packer.use

    -- theme
    use {"glepnir/galaxyline.nvim", branch = "main", requires = "kyazdani42/nvim-web-devicons"} -- statusbar
    use {"romgrk/barbar.nvim", requires = "kyazdani42/nvim-web-devicons"} -- bufferline
    use "norcalli/nvim-colorizer.lua" -- colors hex
    use "Dave-Elec/gruvbox" -- colorscheme
    -- language
    use {"danielnehrig/vim-polyglot"} -- syntax
    use {"jose-elias-alvarez/nvim-lsp-ts-utils", opt = true, ft = {"typescriptreact", "typescript"}} -- eslint code actions
    use "kabouzeid/nvim-lspinstall"
    use {"ruanyl/coverage.vim", opt = true, ft = {"js", "ts", "jsx", "typescriptreact"}} -- jest coverage
    use {"rust-lang/rust.vim", opt = true, ft = {"rust", "rs"}} -- rust language tools
    use {"simrat39/rust-tools.nvim", opt = true, ft = {"rust", "rs"}} -- rust language tools
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        opt = true,
        ft = {"markdown", "md"},
        cmd = "MarkdownPreview"
    } -- markdown previewer
    use {"metakirby5/codi.vim", ft = {"js", "ts", "lua", "typescript", "javascript"}} -- code playground in buffer executed
    use "nvim-treesitter/nvim-treesitter" -- syntax highlight indent etc
    use {"windwp/nvim-ts-autotag", opt = true, ft = {"tsx", "typescriptreact", "jsx", "html"}} -- autotag <>
    use {
        "shuntaka9576/preview-swagger.nvim",
        opt = true,
        run = "yarn install",
        ft = {"yaml", "yml"},
        cmd = "SwaggerPreview"
    } -- openapi preview
    use {"vimwiki/vimwiki", opt = true, cmd = {"VimwikiIndex", "VimwikiDiaryIndex", "VimwikiMakeDiaryNote"}}
    -- snip
    use "norcalli/snippets.nvim" -- snippets
    use "SirVer/ultisnips" -- snippets
    use "hrsh7th/vim-vsnip" -- snippets
    -- completion
    use "ray-x/lsp_signature.nvim" -- auto signature trigger
    use {"ray-x/navigator.lua", requires = {"ray-x/guihua.lua", run = "cd lua/fzy && make"}}
    use {
        "folke/lsp-trouble.nvim",
        config = function()
            require("plugins.trouble")
        end,
        event = "BufRead",
        requires = "kyazdani42/nvim-web-devicons"
    } -- window for showing LSP detected issues in code
    use "nvim-lua/lsp-status.nvim" -- lsp status
    use "glepnir/lspsaga.nvim" -- fancy popups lsp
    use "onsails/lspkind-nvim" -- lsp extensions stuff
    use "nvim-lua/lsp_extensions.nvim" -- lsp extensions inlay hints etc
    use "neovim/nvim-lspconfig" -- default configs for lsp and setup lsp
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = function()
            require("plugins.lspconfig").compe()
        end
    } -- completion engine
    -- navigation
    use {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function()
            require("plugins.telescope")()
        end,
        requires = {
            {"nvim-lua/popup.nvim", opt = true},
            {"nvim-lua/plenary.nvim", opt = true},
            {"nvim-telescope/telescope-fzy-native.nvim", opt = true},
            {"nvim-telescope/telescope-project.nvim", opt = true}
        }
    } -- fuzzy finder
    use {"kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"} -- Drawerboard style like nerdtree
    -- movement
    use "wellle/targets.vim" -- extended motions
    use "adelarsq/vim-matchit" -- matchit % jump
    use "justinmk/vim-sneak" -- movement plugin
    use "unblevable/quick-scope" -- f F t T improved highlight
    -- quality of life
    use "kevinhwang91/nvim-bqf" -- better quickfix
    use "folke/which-key.nvim" -- which key
    use "preservim/nerdcommenter" -- commenting
    use "junegunn/vim-slash" -- better search
    use "windwp/nvim-autopairs" -- autopairs "" {}
    use {"alvan/vim-closetag", opt = true, ft = {"html", "jsx", "tsx", "xhtml", "xml"}} -- close <> tag for xhtml ... maybe remove because of TS tag
    use "tpope/vim-surround" -- surround "" ''
    -- misc
    use "windwp/nvim-projectconfig" -- project dependable cfg
    use "RRethy/vim-illuminate" -- illuminate
    use {"tjdevries/train.nvim", opt = true, cmd = {"TrainClear", "TrainUpDown", "TrainWord", "TrainTextObj"}}
    use {"famiu/nvim-reload", opt = true, cmd = {"Reload", "Restart"}} -- reload nvim config
    use "glepnir/dashboard-nvim" -- dashboard
    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        branch = "lua"
    } -- show indentation
    use {"dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 10]]} -- show startup time
    -- git
    use {
        "sindrets/diffview.nvim",
        config = function()
            require("plugins.diffview")
        end
    }
    use {"TimUntersberger/neogit", event = {"BufRead", "BufNewFile"}, requires = {"nvim-lua/plenary.nvim", opt = true}}
    use {
        "ruifm/gitlinker.nvim",
        config = function()
            require("plugins.gitlinker")
        end
    } -- get repo file on remote as url
    use {"pwntester/octo.nvim", requires = {"nvim-lua/plenary.nvim", opt = true}}
    use {
        "lewis6991/gitsigns.nvim",
        event = {"BufRead", "BufNewFile"},
        config = function()
            require("plugins.gitsigns")
        end,
        requires = {{"nvim-lua/plenary.nvim", opt = true}, {"nvim-lua/popup.nvim", opt = true}}
    } -- like gitgutter shows hunks etc on sign column
    use {"tpope/vim-fugitive", opt = true, cmd = {"Git", "Gdiff"}} -- git integration
    use "APZelos/blamer.nvim" -- line blamer on cursor hold
    -- testing
    use {
        "vim-test/vim-test",
        opt = true,
        cmd = {"TestFile"},
        requires = {
            {"neomake/neomake", opt = true, cmd = {"Neomake"}},
            {"tpope/vim-dispatch", opt = true, cmd = {"Dispatch"}}
        }
    }
    -- debug
    use {"puremourning/vimspector", opt = true} -- debugger
    -- lib
    use {"wbthomason/packer.nvim", opt = true} -- packer
end

local plugins =
    setmetatable(
    {},
    {
        __index = function(_, key)
            if not packer then
                init()
            end
            return packer[key]
        end
    }
)

function plugins.ensure_plugins()
    init()
end

function plugins.convert_compile_file()
    local lines = {}
    local lnum = 1
    lines[#lines + 1] = "vim.cmd [[packadd packer.nvim]]\n"
    for line in io.lines(packer_compiled) do
        lnum = lnum + 1
        if lnum > 15 then
            lines[#lines + 1] = line .. "\n"
            if line == "END" then
                break
            end
        end
    end
    table.remove(lines, #lines)
    if fn.isdirectory(data_path .. "lua") ~= 1 then
        os.execute("mkdir -p " .. data_path .. "lua")
    end
    if fn.filereadable(compile_to_lua) == 1 then
        os.remove(compile_to_lua)
    end
    local file = io.open(compile_to_lua, "w")
    for _, line in ipairs(lines) do
        file:write(line)
    end
    file:close()

    os.remove(packer_compiled)
end

function plugins.auto_compile()
    plugins.compile()
    plugins.convert_compile_file()
end

function plugins.load_compile()
    if fn.filereadable(compile_to_lua) == 1 then
        require('_compiled')
    else
        assert(
            'Missing packer compile file Run PackerCompile Or PackerInstall to fix')
    end
    vim.cmd [[command! PackerCompile lua require('packer-config').auto_compile()]]
    vim.cmd [[command! PackerInstall lua require('packer-config').install()]]
    vim.cmd [[command! PackerUpdate lua require('packer-config').update()]]
    vim.cmd [[command! PackerSync lua require('packer-config').sync()]]
    vim.cmd [[command! PackerClean lua require('packer-config').clean()]]
    vim.cmd [[autocmd User PackerComplete lua require('packer-config').auto_compile()]]
    vim.cmd [[command! PackerStatus  lua require('packer-config').status()]]
end

return plugins
