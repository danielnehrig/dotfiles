local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local folder_list = function(opts)
    local dir = opts.path or ""
    local list = {}
    local p = io.popen("rg --files --hidden " .. dir)
    for file in p:lines() do
        table.insert(list, file)
    end
    return list
end

local file_create = function(opts)
    opts = opts or {}
    local results = folder_list(opts)

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
            sorter = conf.file_sorter(opts)
        }
    ):find()
end

return telescope.register_extension {exports = {file_create = file_create}}
