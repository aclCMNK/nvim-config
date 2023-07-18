"KEY-BINDING////////////////////////////
let mapleader = "\<Space>"
lua vim.api.nvim_set_keymap('i', '<leader>', '<leader>', { silent = true })

"--CLOSE EDITOR//////////////
nnoremap <C-q> <ESC>:CloseAll<CR>
inoremap <C-q> <ESC>:CloseAll<CR>
"--IDENTATION////////////////
imap <TAB> <ESC>:><CR>A
nmap <TAB> <ESC>:><CR>
vmap <TAB> :><CR>
"--BACK IDENTATION///////////
imap <S-TAB> <ESC>:<<CR>A
nmap <S-TAB> <ESC>:<<CR>
vmap <S-TAB> :<<CR>
"--NEXT/PREV BUFFER//////////
imap <leader><TAB> <ESC>:bnext<CR>
nmap <leader><TAB> <ESC>:bnext<CR>
vmap <leader><TAB> <ESC>:bnext<CR>

imap <leader><S-TAB> <ESC>:bprevious<CR>
nmap <leader><S-TAB> <ESC>:bprevious<CR>
vmap <leader><S-TAB> <ESC>:bprevious<CR>
"--SAVE FILE///////////////
imap <C-s> <ESC>:w!<CR>
nmap <C-s> <ESC>:w!<CR>
vmap <C-s> <ESC>:w!<CR>

"--NEW TAB
imap <A-t> <ESC>:tabnew<CR>
nmap <A-t> <ESC>:tabnew<CR>
vmap <A-t> <ESC>:tabnew<CR>
"--NEXT TAB
imap <A-RIGHT> <ESC>:vsplit<CR>
nmap <A-RIGHT> <ESC>:vsplit<CR>
vmap <A-RIGHT> <ESC>:vsplit<CR>
"--PREV TAB
imap <A-LEFT> <ESC>:split<CR>
nmap <A-LEFT> <ESC>:split<CR>
vmap <A-LEFT> <ESC>:split<CR>
"--REMOVE PANEL
imap <A-c> <ESC>:close<CR>
nmap <A-c> <ESC>:close<CR>
vmap <A-c> <ESC>:close<CR>
"--RESIZE RIGHT PANEL VERTICALLY
imap <leader><LEFT> <ESC>:vertical resize +5<CR>
nmap <leader><LEFT> <ESC>:vertical resize +5<CR>
vmap <leader><LEFT> <ESC>:vertical resize +5<CR>
"--RESIZE LEFT PANEL VERTICALLY
imap <leader><RIGHT> <ESC>:vertical resize -5<CR>
nmap <leader><RIGHT> <ESC>:vertical resize -5<CR>
vmap <leader><RIGHT> <ESC>:vertical resize -5<CR>
"--RESIZE DOWN PANEL HORIZONTALLY
imap <leader><UP> <ESC>:resize +5<CR>
nmap <leader><UP> <ESC>:resize +5<CR>
vmap <leader><UP> <ESC>:resize +5<CR>
"--RESIZE UP PANEL HORIZONTALLY
imap <leader><DOWN> <ESC>:resize -5<CR>
nmap <leader><DOWN> <ESC>:resize -5<CR>
vmap <leader><DOWN> <ESC>:resize -5<CR>
"--DIR FILES
imap <A-f> <ESC>:Files<CR>
nmap <A-f> <ESC>:Files<CR>
vmap <A-f> <ESC>:Files<CR>
"--CLOSE OPENED FIES
nnoremap <A-q> <ESC>:CloseBuffer<CR>
imap <A-d> <ESC>:CloseBuffer<CR>
"--MOVE UP 5 POINTS
imap <S-UP> <ESC>:-5<CR>
nmap <S-UP> <ESC>:-5<CR>
vmap <S-UP> <ESC>:-5<CR>
"--MOVE DOWN 5 POINTS
imap <S-DOWN> <ESC>:+5<CR>
nmap <S-DOWN> <ESC>:+5<CR>
vmap <S-DOWN> <ESC>:+5<CR>
"--UNDO
imap <C-z> <ESC>:undo<CR>
nmap <C-z> <ESC>:undo<CR>
vmap <C-z> <ESC>:undo<CR>
"--REDO
imap <C-y> <ESC>:redo<CR>
nmap <C-y> <ESC>:redo<CR>
vmap <C-y> <ESC>:redo<CR>
"--SELECT ALL LINES
imap <C-A-a> <ESC>G$v0gg
nmap <C-A-a> <ESC>G$v0gg
nmap <C-A-a> <ESC>G$v0gg
nnoremap <leader>sl <ESC>0v$

nnoremap <C-f> <ESC>:Search 
inoremap <C-f> <ESC>:Search 
nnoremap <C-g> <ESC>:SearchAll 
inoremap <C-g> <ESC>:SearchAll 

nnoremap <leader>ft <ESC>:Search 
nnoremap <leader>fa <ESC>:SearchAll 

nnoremap <C-r> <ESC>:source $HOME/.config/nvim/init.vim<CR>




"PLUGINS:
"--BUFFER MANAGER
inoremap <C-A-l> <ESC>:OpenedFiles<CR>
nnoremap <C-A-l> <ESC>:OpenedFiles<CR>

"--COC
nnoremap <silent>gd :GotoDefinition<CR>
nnoremap <silent>vd :DefinitionPreview<CR>
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <expr> <silent> <C-d> <SID>select_current_word()

"--MEMENTO
nnoremap <C-A-k> <ESC>:Memento<CR>

"--NVIMTREE
nnoremap <C-b> <ESC>:NvimTreeFindFileToggle<CR>

"--SYMBOLS-OUTLINE
"----Default keymaps
    "Key	        Action
    "Escape	        Close outline
    "Enter	        Go to symbol location in code
    "o	            Go to symbol location in code without losing focus
    "Ctrl+Space	    Hover current symbol
    "K	            Toggles the current symbol preview
    "r	            Rename symbol
    "a	            Code actions
    "h	            fold symbol
    "l	            Unfold symbol
    "W	            Fold all symbols
    "E	            Unfold all symbols
    "R	            Reset all folding
    "?	            Show help message

"--Highlights
    "Highlight	                Purpose
    "FocusedSymbol	            Highlight of the focused symbol
    "Pmenu	                    Highlight of the preview popup windows
    "SymbolsOutlineConnector	Highlight of the table connectors
    "Comment	                Highlight of the info virtual text

"--TELESCOPE
nnoremap <leader>fb :Telescope file_browser path=%:p:h select_buffer=true<CR>
nnoremap <leader>fp :Telescope project path=%:p:h select_buffer=true<CR>
"inoremap <C-A-l> <ESC>:Telescope buffers<CR>
"nnoremap <C-A-l> <ESC>:Telescope buffers<CR>
inoremap <C-A-f> <ESC>:Telescope find_files<CR>
nnoremap <C-A-f> <ESC>:Telescope find_files<CR>
inoremap <C-A-g> <ESC>:Telescope grep_string<CR>
nnoremap <C-A-g> <ESC>:Telescope grep_string<CR>


