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
    use "glepnir/galaxyline.nvim"
    use {"akinsho/nvim-bufferline.lua", disable = true}
    use 'romgrk/barbar.nvim'
    use "norcalli/nvim-colorizer.lua"
    use "ryanoasis/vim-devicons"
    use {"ayu-theme/ayu-vim", disable = false}
    use "Dave-Elec/gruvbox"
    use 'arzg/vim-substrata'
    use "kyazdani42/nvim-web-devicons"
    -- language
    use 'rust-lang/rust.vim'
    use {'danielnehrig/vim-polyglot', config = function() require'core.callback' end}
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
    use "metakirby5/codi.vim"
    use 'nvim-treesitter/nvim-treesitter'
    -- lint
    use "dense-analysis/ale"
    -- snip
    use "norcalli/snippets.nvim"
    use "SirVer/ultisnips"
    use "hrsh7th/vim-vsnip"
    -- completion
    use "nvim-lua/lsp-status.nvim"
    use "glepnir/lspsaga.nvim"
    use "onsails/lspkind-nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-compe"
    -- navigation
    use "nvim-telescope/telescope-github.nvim"
    use "nvim-telescope/telescope-project.nvim"
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use "nvim-telescope/telescope-media-files.nvim"
    use "kyazdani42/nvim-tree.lua"
    -- misc
    use "liuchengxu/vim-which-key"
    use "norcalli/nvim_utils"
    use "preservim/nerdcommenter"
    use "glepnir/dashboard-nvim"
    use "junegunn/vim-slash"
    use "windwp/nvim-autopairs"
    use "unblevable/quick-scope"
    use "alvan/vim-closetag"
    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua'
    }
    use {'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]]}
    use "tpope/vim-surround"
    -- git
    use "lewis6991/gitsigns.nvim"
    use "tpope/vim-fugitive"
    use 'APZelos/blamer.nvim'
    -- testing
    use "vim-test/vim-test"
    use "tpope/vim-dispatch"
    use "neomake/neomake"
    -- debug
    use "puremourning/vimspector"
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
