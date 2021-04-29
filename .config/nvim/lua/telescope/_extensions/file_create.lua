local telescope = require("telescope")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local Path = require("plenary.path")
local os_sep = Path.path.sep

local folder_list = function()
    local list = {}
    local p = io.popen("find . -type d")
    for file in p:lines() do
        table.insert(list, file)
    end
    return list
end

local file_create = function(opts)
    opts = opts or {}
    local results = folder_list()

    pickers.new(
        opts,
        {
            prompt_title = "Create file in",
            results_title = "File Creation",
            finder = finders.new_table {
                results = results,
                entry_maker = make_entry.gen_from_file(opts)
            },
            previewer = conf.file_previewer(opts),
            sorter = conf.file_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                action_set.select:replace_if(
                    function()
                        return action_state.get_selected_entry().path:sub(-1) == os_sep
                    end,
                    function()
                        local new_cwd = vim.fn.expand(action_state.get_selected_entry().path:sub(1, -2))
                        local current_picker = action_state.get_current_picker(prompt_bufnr)
                        current_picker.cwd = new_cwd
                        current_picker:refresh(opts.new_finder(new_cwd), {reset_prompt = true})
                    end
                )

                local create_new_file = function()
                    local current_picker = action_state.get_current_picker(prompt_bufnr)
                    local file = action_state.get_current_line()
                    if file == "" then
                        print(
                            "To create a new file or directory(add " ..
                                os_sep ..
                                    " at the end of file) " ..
                                        "write the desired new into the prompt and press <C-e>. " ..
                                            "It works for not existing nested input as well." ..
                                                "Example: this" ..
                                                    os_sep .. "is" .. os_sep .. "a" .. os_sep .. "new_file.lua"
                        )
                        return
                    end

                    local fpath = current_picker.cwd .. os_sep .. file
                    if string.sub(fpath, -1) ~= os_sep then
                        actions.close(prompt_bufnr)
                        Path:new(fpath):touch({parents = true})
                        vim.cmd(string.format(":e %s", fpath))
                    else
                        Path:new(fpath:sub(1, -2)):mkdir({parents = true})
                        local new_cwd = vim.fn.expand(fpath)
                        current_picker.cwd = new_cwd
                        current_picker:refresh(opts.new_finder(new_cwd), {reset_prompt = true})
                    end
                end

                map("i", "<C-e>", create_new_file)
                map("n", "<C-e>", create_new_file)
                return true
            end
        }
    ):find()
end

return telescope.register_extension {exports = {file_create = file_create}}
