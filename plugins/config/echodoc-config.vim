" Or, you could use neovim's floating window feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" You could configure the behaviour of the floating window like below:
let g:echodoc#floating_config = {'border': 'single'}
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu
