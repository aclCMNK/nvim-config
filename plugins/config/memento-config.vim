lua << EOF

vim.g.memento_history = 20
vim.g.memento_shorten_path = true
vim.g.memento_window_width = 80
vim.g.memento_window_height = 14

EOF

command! Memento :lua require("memento").toggle()
command! MementoClear :lua require("memento").clear_history()

nnoremap <C-A-k> <ESC>:Memento<CR>
