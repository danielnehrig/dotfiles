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
        use {"chriskempson/base16-vim"}
        use {"ryanoasis/vim-devicons"}
        use {"Dave-Elec/gruvbox"}
        -- language
        use {"dense-analysis/ale"}
        use {"sheerun/vim-polyglot"}
        use {'rust-lang/rust.vim'}
        use {"nvim-treesitter/nvim-treesitter"}
        -- completion
        use {"onsails/lspkind-nvim"}
        use {"neovim/nvim-lspconfig"}
        use {"nvim-lua/completion-nvim"}
        -- navigation
        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-media-files.nvim"}
        use {"kyazdani42/nvim-tree.lua"}
        -- misc
        use {"mhinz/vim-startify"}
        use {"junegunn/vim-slash"}
        use {"windwp/nvim-autopairs"}
        use {"unblevable/quick-scope"}
        use {"nvim-lua/plenary.nvim"}
        use {"alvan/vim-closetag"}
        use {"907th/vim-auto-save"}
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
    end
)
