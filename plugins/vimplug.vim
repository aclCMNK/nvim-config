call plug#begin()

    Plug 'OmniSharp/omnisharp-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'Shougo/echodoc.vim'

	Plug 'habamax/vim-godot'

	Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
	Plug 'junegunn/fzf.vim' " needed for previews
	Plug 'antoinemadec/coc-fzf'
	Plug 'jdonaldson/vaxe'
	
" post install (yarn install | npm install) then load plugin only for editing supported files
"	Plug 'prettier/vim-prettier', {
"	  \ 'do': 'yarn install --frozen-lockfile --production',
"	  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

call plug#end()

source $HOME/.config/nvim/plugins/config/coc-config.vim
source $HOME/.config/nvim/plugins/config/omnisharp-config.vim
source $HOME/.config/nvim/plugins/config/echodoc-config.vim
"source $HOME/.config/nvim/plugins/config/prettier-config.vim

lua << EOF
vim.g.coc_global_extensions = {'coc-explorer'}
EOF
