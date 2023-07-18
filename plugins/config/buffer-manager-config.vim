lua << EOF

local opts = {noremap = true}
local map = vim.keymap.set
-- Setup
require("buffer_manager").setup({
  select_menu_item_commands = {
    v = {
      key = "<C-v>",
      command = "vsplit"
    },
    h = {
      key = "<C-h>",
      command = "split"
    }
  },
  focus_alternate_buffer = false,
  short_file_names = true,
  short_term_names = true,
  loop_nav = false,
})


EOF

command! OpenedFiles :lua require("buffer_manager.ui").toggle_quick_menu()
inoremap <C-A-l> <ESC>:OpenedFiles<CR>
nnoremap <C-A-l> <ESC>:OpenedFiles<CR>
