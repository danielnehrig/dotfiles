vim.api.nvim_exec(
[[
let g:startify_session_persistence = 1
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_dir = 0

set efm+=%.%#\ at\ %f:%l:%c,%.%#\ at\ %.%#(%f:%l:%c)
set efm+=%.%#\ at\ %.%#(%f:%l:%c),%-G%.%#
]],
true)
