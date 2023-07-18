lua << EOF

local api = require("LspUI").api
-- Default config
require("LspUI").setup({
    lightbulb = {
        enable = false, -- close by default
        command_enable = false, -- close by default, this switch does not have to be turned on, this command has no effect
        icon = "💡",
    },
    code_action = {
        enable = true,
        command_enable = true,
        icon = "💡",
        keybind = {
            exec = "<CR>",
            prev = "k",
            next = "j",
            quit = "q",
        },
    },
    hover = {
        enable = true,
        command_enable = true,
        keybind = {
            prev = "p",
            next = "n",
            quit = "q",
        },
    },
    rename = {
        enable = true,
        command_enable = true,
        auto_select = true, -- whether select all automatically
        keybind = {
            change = "<CR>",
            quit = "<ESC>",
        },
    },
    diagnostic = {
        enable = true,
        command_enable = true,
        icons = {
            Error = " ",
            Warn = " ",
            Info = " ",
            Hint = " ",
        },
    },
    peek_definition = {
        enable = false, -- close by default
        command_enable = true,
        keybind = {
            edit = "op",
            vsplit = "ov",
            split = "os",
            quit = "q",
        },
    },
})

EOF

nnoremap <leader>ldn <ESC>:LspUI diagnostic next<CR>
nnoremap <leader>ldp <ESC>:LspUI diagnostic prev<CR>
nnoremap <leader>lho <ESC>:LspUI hover<CR>
nnoremap <leader>lrn <ESC>:LspUI rename<CR>
nnoremap <leader>lca <ESC>:LspUI code_action<CR>

command! RenamePop :LspUI rename
command! Doc :LspUI hover
command! CodeAction :LspUI code_action
command! LspDiagNext :LspUI diagnostic next
command! LspDiagPrev :LspUI diagnostic prev
command! Definition :LspUI peek_definition
