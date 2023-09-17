"EDITOR PROPS////////////////////////////
set number relativenumber
set ignorecase
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set cursorline
"set cursorcolumn
set clipboard+=unnamedplus
set completeopt=noinsert,menuone,noselect
set wildmenu
set title
set ttimeoutlen=0
set splitbelow splitright
set t_Co=256
set nowrap!
set incsearch
"set foldmethod=syntax
"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()
filetype plugin indent on
syntax on
set timeoutlen=100

set encoding=UTF-8

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=

" Enable devicons
let g:DevIconsEnableFoldersOpenClose = 1

" Configure diagnostic icons
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = '' " Icon for files without diagnostic
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {
     \ 'Error': '',
     \ 'Warning': '',
     \ 'Information': '',
     \ 'Hint': ''
     \ }

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=350}

"ITALIC FONTS/////////////////////////
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
":EXPLORER SETTINGS//////////////////
let g:netrw_banner=1
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_altv=0
let g:netrw_winsize=25
let g:netrw_keepdir=0
let g:netrw_localcopydircmd='cp -r'
"COMMANDS///////////////////////////////
command! EXP :Explorer
command! KPathFiles :Files
"///////////////////////////////////////////////
"////COLOR CONFIGURATION
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" True color if available
let term_program=$TERM_PROGRAM
" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
    set termguicolors
else
    if $TERM !=? 'xterm-256color'
        set termguicolors
    endif
endif
set t_Co=256
set background=dark


source $HOME/.config/nvim/setup/colorscheme.vim
source $HOME/.config/nvim/plugins/packer.vim
source $HOME/.config/nvim/plugins/vimplug.vim
source $HOME/.config/nvim/setup/commands.vim
source $HOME/.config/nvim/setup/keys.vim

"////AUTOCOMPLETE MENU COLOR
" You can use the following highlight groups:
" Pmenu – normal item
" PmenuSel – selected item
" PmenuSbar – scrollbar
" PmenuThumb – thumb of the scrollbar
" hi Pmenu guibg=DarkCyan guifg=Cyan
" hi PmenuSel guibg=cyan

hi Pmenu guibg=#2b2b2b guifg=#666666
hi PmenuSel guibg=#455861 guifg=#74a9c2

