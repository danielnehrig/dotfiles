-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(
    function()
        -- packer
        use {"wbthomason/packer.nvim", opt = true}
        -- theme
        use {"glepnir/galaxyline.nvim"}
        use {"akinsho/nvim-bufferline.lua"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"ryanoasis/vim-devicons"}
        use {"ayu-theme/ayu-vim"}
        use {"kyazdani42/nvim-web-devicons"}
        -- language
        use {'rust-lang/rust.vim'}
        use {'danielnehrig/vim-polyglot', config = function() require'core.callback' end}
        use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
        use {"metakirby5/codi.vim"}
        -- lint
        use {"dense-analysis/ale"}
        -- snip
        use {"norcalli/snippets.nvim"}
        use {"SirVer/ultisnips"}
        use {"hrsh7th/vim-vsnip"}
        -- completion
        use {"nvim-lua/lsp-status.nvim"}
        use {"glepnir/lspsaga.nvim"}
        use {"onsails/lspkind-nvim"}
        use {"nvim-lua/lsp_extensions.nvim"}
        use {"neovim/nvim-lspconfig"}
        use {"hrsh7th/nvim-compe"}
        -- navigation
        use {"nvim-telescope/telescope-github.nvim"}
        use {"nvim-telescope/telescope-project.nvim"}
        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-media-files.nvim"}
        use {"kyazdani42/nvim-tree.lua"}
        -- misc
        use {"liuchengxu/vim-which-key"}
        use {"norcalli/nvim_utils"}
        use {"preservim/nerdcommenter"}
        use {"glepnir/dashboard-nvim"}
        use {"junegunn/vim-slash"}
        use {"windwp/nvim-autopairs"}
        use {"unblevable/quick-scope"}
        use {"nvim-lua/plenary.nvim"}
        use {"alvan/vim-closetag"}
        use {"lukas-reineke/indent-blankline.nvim"}
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
