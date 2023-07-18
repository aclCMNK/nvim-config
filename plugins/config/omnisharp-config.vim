let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
let g:OmniSharp_diagnostic_showid = 1
let g:coc_global_extensions = [
			\'coc-omnisharp'
			\]

let g:LanguageClient_auto_start = 1
let g:OmniSharp_language_server_type = 'omnisharp'
let g:OmniSharp_popup_position = 'peek'
let g:OmniSharp_auto_complete_commit_character = '.'
let g:OmniSharp_godot_executable = '~/Tools/Godot_v4.1-stable_mono_linux_x86_64/Godot_v4.1-stable_mono_linux.x86_64'
let g:LanguageClient_godot_executable = '~/Tools/Godot_v4.1-stable_mono_linux_x86_64/Godot_v4.1-stable_mono_linux.x86_64'

let g:LanguageClient_serverCommands = {
    \ 'csharp': ['OmniSharp', '--languageserver', '--hostPID', '1'],
    \ }
autocmd FileType cs call languageclient#enable()

"let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_selector_ui = 'omnicomplete'
let g:OmniSharp_language_server_executable = 'dotnet'

let g:godot_executable = '~/Tools/Godot_v4.1-stable_mono_linux_x86_64/Godot_v4.1-stable_mono_linux.x86_64'

let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [1],
\ 'border': [1],
\ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
\ 'borderhighlight': ['Special']
\}
