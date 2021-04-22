require "nvim-treesitter.configs".setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = false
    },
    indent = {
        enable = false
    },
    autotag = {
        enable = true
    }
}
