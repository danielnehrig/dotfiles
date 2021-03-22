" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/dNehrig/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/dNehrig/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/dNehrig/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/dNehrig/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/dNehrig/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ale = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["blamer.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/blamer.nvim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  indentLine = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  neomake = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/neomake"
  },
  nerdcommenter = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-closetag"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-slash"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-slash"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  vimspector = {
    loaded = true,
    path = "/Users/dNehrig/.local/share/nvim/site/pack/packer/start/vimspector"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry