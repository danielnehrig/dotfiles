local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

local packer = nil
local function init()
    if packer == nil then
        packer = require('packer')
        packer.init({disable_commands = true})
    end

    local use = packer.use
    packer.reset()

    use {"wbthomason/packer.nvim", opt = true}
    -- theme
    use "glepnir/galaxyline.nvim" -- statusbar
    use 'adelarsq/vim-matchit' -- matchit % jump
    use 'romgrk/barbar.nvim' -- bufferline
    use "norcalli/nvim-colorizer.lua" -- colors hex
    use "ryanoasis/vim-devicons" -- devicons
    use "Dave-Elec/gruvbox" -- colorscheme
    use "kyazdani42/nvim-web-devicons" -- more icons
    -- language
    use {'rust-lang/rust.vim', ft = {'rust', 'rs'}}
    use {'simrat39/rust-tools.nvim', ft = {'rust', 'rs'}}
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', ft = {'markdown', 'md'}, cmd = 'MarkdownPreview'}
    use {"metakirby5/codi.vim", ft = {'js', 'ts', 'lua', 'typescript', 'javascript'}}
    use "nvim-treesitter/nvim-treesitter"
    use 'windwp/nvim-ts-autotag'
    use {'shuntaka9576/preview-swagger.nvim', run = 'yarn install', ft = {'yaml', 'yml'}, cmd = 'SwaggerPreview'}
    -- lint
    use {"dense-analysis/ale"} -- linter TODO replace with efm
    -- snip
    use "norcalli/snippets.nvim" -- snippets
    use "SirVer/ultisnips" -- snippets
    use "hrsh7th/vim-vsnip" -- snippets
    -- completion
    use "nvim-lua/lsp-status.nvim" -- lsp status
    use "glepnir/lspsaga.nvim" -- fancy popups lsp
    use "onsails/lspkind-nvim"
    use "nvim-lua/lsp_extensions.nvim" -- lsp extensions inlay hints etc
    use "neovim/nvim-lspconfig" -- default configs for lsp and setup lsp
    use "hrsh7th/nvim-compe" -- completion engine
    use {'tzachar/compe-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-compe'} -- tabnine completion engine AI
    -- navigation
    use "nvim-telescope/telescope-github.nvim" -- github telescope
    use "nvim-telescope/telescope-project.nvim" -- project manager
    use "nvim-telescope/telescope.nvim" -- fuzzy finder
    use "nvim-lua/popup.nvim" -- LIB
    use "nvim-lua/plenary.nvim" -- LIB
    use "nvim-telescope/telescope-media-files.nvim" -- media files showing
    use "kyazdani42/nvim-tree.lua" -- Drawboard style like nerdtree
    -- misc
    use "liuchengxu/vim-which-key" -- show key/map functionality for map chain
    use 'justinmk/vim-sneak' -- movement plugin
    use "norcalli/nvim_utils" -- utils
    use "preservim/nerdcommenter" -- commenting
    use "glepnir/dashboard-nvim" -- dashboard
    use "junegunn/vim-slash" -- better search
    use "windwp/nvim-autopairs" -- autopairs "" {}
    use "unblevable/quick-scope" -- f F t T improved highlight
    use "alvan/vim-closetag" -- ?
    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua'
    } -- show indentation
    use {'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]]} -- show startup time
    use "tpope/vim-surround" -- surround "" ''
    -- git
    use 'ruifm/gitlinker.nvim' -- get repo file on remote as url
    use "lewis6991/gitsigns.nvim" -- like gitgutter shows hunks etc on sign column
    use "tpope/vim-fugitive" -- git integration
    use 'tpope/vim-rhubarb' -- GBrowse for gh
    use 'APZelos/blamer.nvim' -- line blamer on cursor hold
    -- testing
    use "vim-test/vim-test" -- vim testing
    use "tpope/vim-dispatch" -- different building and run solution
    use "neomake/neomake" -- same as dispatch but async
    -- debug
    use {"puremourning/vimspector", disable = true} -- debugger
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})

cmd [[command! PackerInstall packadd packer.nvim | lua require('pluginsList.lua').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('pluginsList.lua').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('pluginsList.lua').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('pluginsList.lua').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('pluginsList.lua').compile()]]

return plugins
