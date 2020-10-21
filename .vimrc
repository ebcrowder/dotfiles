call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'rust-lang/rust.vim'
Plug 'tomasiser/vim-code-dark'
call plug#end()

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


" vim-lsp 
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ })
endif


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gh <plug>(lsp-hover)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlight_references_enabled = 1

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
