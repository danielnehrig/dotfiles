local cmd = vim.cmd
local nvim_command = vim.api.nvim_command
-- highlights
cmd("hi LineNr guibg=NONE")
cmd("hi SignColumn guibg=NONE")
cmd("hi VertSplit guibg=NONE")
cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
cmd("hi DiffChange guifg =#3A3E44 guibg = none")
cmd("hi DiffModified guifg = #81A1C1 guibg = none")
cmd("hi EndOfBuffer guifg=#282c34")

cmd("hi TelescopeBorder   guifg=#3e4451")
cmd("hi TelescopePromptBorder   guifg=#3e4451")
cmd("hi TelescopeResultsBorder  guifg=#3e4451")
cmd("hi TelescopePreviewBorder  guifg=#525865")
cmd("hi PmenuSel  guibg=#98c379")

-- tree folder name , icon color
cmd("hi NvimTreeFolderIcon guifg = #61afef")
cmd("hi NvimTreeIndentMarker guifg=#545862")
cmd("hi CustomExplorerBg guibg=#242830")
nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")

-- gitsigns transparent

-- set signs transparent on terminal app
if not vim.g.neovide or not vim.g.goneovim or not vim.g.uivonim then
    cmd("hi GruvboxGreenSign ctermbg=none guibg=none")
    cmd("hi GruvboxRedSign ctermbg=none guibg=none")
    cmd("hi GruvboxRedSign ctermbg=none guibg=none")
    cmd("hi GruvboxAquaSign ctermbg=none guibg=none")
end
