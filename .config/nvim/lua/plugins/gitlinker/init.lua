require("gitlinker").setup(
    {
        opts = {
            remote = nil, -- force the use of a specific remote
            -- adds current line nr in the url for normal mode
            add_current_line_on_normal_mode = true,
            -- callback for what to do with the url
            action_callback = require("gitlinker.actions").copy_to_clipboard
        },
        callbacks = {
            ["github.com"] = require("gitlinker.hosts").get_github_type_url,
            ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url
        },
        mappings = "<leader>gy" -- mapping to call url generation
    }
)
