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

" coc-nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ale
let g:ale_disable_lsp = 1
let g:ale_set_highlights = 0
let g:ale_linters_explicit = 1
let g:ale_fixers = {
\   'rust': ['rustfmt'],
\   'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace'],
\   'typescript': ['prettier'],
\   'javascript': ['prettier'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'markdown': ['prettier'],
\}

" fzf
nnoremap <C-p> :Files<CR>

" rust 
let g:rustfmt_autosave = 1

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
