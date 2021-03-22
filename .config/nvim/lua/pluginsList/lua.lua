-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(
    function()
        -- packer
        use {"wbthomason/packer.nvim", opt = true}
        -- theme
        use {"glepnir/galaxyline.nvim"}
        use {"kyazdani42/nvim-web-devicons"}
        use {"akinsho/nvim-bufferline.lua"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"glepnir/lspsaga.nvim"}
        use {"ryanoasis/vim-devicons"}
        use {"apzelos/blamer.nvim"}
        use {"Dave-Elec/gruvbox"}
        use {"lukas-reineke/indent-blankline.nvim"}
        -- language
        use {"dense-analysis/ale"}
        use {"sheerun/vim-polyglot"}
        use {'rust-lang/rust.vim'}
        use {"nvim-treesitter/nvim-treesitter"}
        -- completion
        use {"onsails/lspkind-nvim"}
        use {"nvim-lua/lsp_extensions.nvim"}
        use {"neovim/nvim-lspconfig"}
        -- use {"nvim-lua/completion-nvim"}
        use {"hrsh7th/nvim-compe"}
        -- navigation
        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-media-files.nvim"}
        use {"kyazdani42/nvim-tree.lua"}
        -- misc
        use {"norcalli/nvim_utils"}
        use {"preservim/nerdcommenter"}
        use {"windwp/nvim-ts-autotag"}
        use {"mhinz/vim-startify"}
        use {"junegunn/vim-slash"}
        use {"windwp/nvim-autopairs"}
        use {"unblevable/quick-scope"}
        use {"nvim-lua/plenary.nvim"}
        use {"alvan/vim-closetag"}
        use {"Yggdroot/indentLine"}
        use {"tweekmonster/startuptime.vim"}
        use {"tpope/vim-surround"}
        use {"nvim-lua/popup.nvim"}
        -- git
        use {"lewis6991/gitsigns.nvim"}
        use {"tpope/vim-fugitive"}
        -- testing
        use {"vim-test/vim-test"}
        use {"tpope/vim-dispatch"}
        use {"neomake/neomake"}
        -- debug
        use {"puremourning/vimspector"}
    end
)
