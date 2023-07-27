
function! SetupCSharp()
    let g:coc_suggest_unchanged = 1
    let g:coc_snippet_next = '<tab>'
endfunction

function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

let g:coc_global_extensions = ['coc-csharp', 'coc-prettier']
" Set the path to your Godot engine
let g:coc_godot_executable = '~/Tools/Godot_v4.1-stable_mono_linux_x86_64/Godot_v4.1-stable_mono_linux.x86_64'
" Configure CoC for C#
autocmd FileType cs source ~/.vim/coc/coc.vim
augroup mygroup
    autocmd!
    autocmd FileType cs call SetupCSharp()
augroup end
