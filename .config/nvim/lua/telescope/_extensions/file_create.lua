local telescope = require("telescope")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local action_state = require("telescope.actions.state")
local Path = require("plenary.path")
-- local action_set = require("telescope.actions.set")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
-- local Path = require("plenary.path")
-- local os_sep = Path.path.sep
local open_mode = vim.loop.constants.O_CREAT + vim.loop.constants.O_WRONLY + vim.loop.constants.O_TRUNC

local folder_list = function()
    local list = {}
    local p = io.popen("find . -type d")
    for file in p:lines() do
        table.insert(list, file:sub(3))
    end
    return list
end

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

local function clear_prompt()
    vim.api.nvim_command("normal :esc<CR>")
end

local function get_user_input()
    return vim.fn.nr2char(vim.fn.getchar())
end

local function remove_dir(cwd)
    return vim.loop.fs_rmdir(cwd .. "/")
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
                local get_marked_files = function()
                    local current_picker = action_state.get_current_picker(prompt_bufnr)
                    local multi_selected = current_picker:get_multi_selection()
                    local entries

                    if vim.tbl_isempty(multi_selected) then
                        entries = {action_state.get_selected_entry()}
                    else
                        entries = multi_selected
                    end

                    local selected =
                        vim.tbl_map(
                        function(entry)
                            return Path:new(entry[1])
                        end,
                        entries
                    )

                    return selected
                end
                local create_new_file = function(bufnr)
                    local new_cwd = vim.fn.expand(action_state.get_selected_entry().path)
                    local fileName = vim.fn.input("File Name: ")
                    if fileName == "" and not new_cwd then
                        print("To create a new file name or directory")
                        return
                    end
                    local result = new_cwd .. "/" .. fileName
                    actions.close(bufnr)
                    Path:new(result):touch({parents = true})
                    vim.cmd(string.format(":e %s", result))
                end

                local remove_file = function()
                    local current_picker = action_state.get_current_picker(prompt_bufnr)
                    local marked_files = get_marked_files()

                    print("These files are going to be deleted:")
                    for _, file in ipairs(marked_files) do
                        print(file.filename)
                    end

                    local confirm =
                        vim.fn.confirm(
                        "You're about to perform a destructive action." .. " Proceed? [y/N]: ",
                        "&Yes\n&No",
                        "No"
                    )

                    if confirm == 1 then
                        current_picker:delete_selection(
                            function(entry)
                                local p = Path:new(entry[1])
                                p:rm({recursive = p:is_dir()})
                            end
                        )
                        print("\nThe file has been removed!")
                        current_picker:reset_multi_selection()
                    end
                end

                map("i", "<C-e>", create_new_file)
                map("n", "<C-e>", create_new_file)
                map("i", "<C-d>", remove_file)
                map("n", "<C-d>", remove_file)
                return true
            end
        }
    ):find()
end

return telescope.register_extension {exports = {file_create = file_create}}
