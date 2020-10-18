" vimrc
" plugins are managed at .vim/pack/plugins/start as git submodules

" add a plugin:
"" git submodule add PLUGIN_URL/PLUGIN_NAME.git .vim/pack/plugins/start/PLUGIN_NAME
"" git add .gitmodules .vim/pack/plugins/start/PLUGIN_NAME

" update a plugin:
"" git submodule update --remote

" rm a plugin:
"" git submodule deinit .vim/pack/plugins/start/PLUGIN_NAME
"" git rm .vim/pack/plugins/start/PLUGIN_NAME
"" rm -rf .git/modules/.vim/pack/plugins/start/PLUGIN_NAME

"""""""""""""""""""""""""""""""""""""""""""""""
" plugin config
"""""""""""""""""""""""""""""""""""""""""""""""
" theme
set t_Co=256
colorscheme codedark 
syntax on

" fzf
nnoremap <C-p> :Files<CR>

" rust 
let g:rustfmt_autosave = 1

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_auto_type_info = 1 
let g:go_metalinter_autosave = 1

"""""""""""""""""""""""""""""""""""""""""""""""
" general config
"""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8 " set default encoding to UTF-8
set autoindent " autoindent
set number " show line numbers
set hidden " allow opening new buffers without writing file
set showcmd " show what I am typing
set backupdir=~/.cache " backup files dir
set directory=~/.cache " swp files dir
set incsearch " highlight search results
set showmatch " highlight matching parens, braces and brackets
set hlsearch " highlight all search results
set noerrorbells " no error bells
set backspace=indent,eol,start " enable backspace in insert mode
filetype plugin on " enable plugins
