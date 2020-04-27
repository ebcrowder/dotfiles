" ec vimrc config
" plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" theme
Plug 'tomasiser/vim-code-dark'
" rust
Plug 'rust-lang/rust.vim'
" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
" prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
" comments
Plug 'tpope/vim-commentary'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""
" theme
colorscheme codedark 

" netrw
map <silent> <C-b> :Lexplore <CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" vim-lsp 
" cargo install --git https://github.com/rust-analyzer/rust-analyzer rust-analyzer
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <C-k> <plug>(lsp-hover)
    nmap <buffer> <f2> <plug>(lsp-rename)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1 
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 200
let g:lsp_highlight_references_enabled = 1

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1

" format on save 
let g:rustfmt_autosave = 1
let g:prettier#autoformat = 1

"""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8 " set default encoding to UTF-8
set number " show line numbers
set showcmd " show what I am typing
set noswapfile " do not use swapfile
set nobackup " do not use backup files
set noerrorbells " no error bells
set backspace=indent,eol,start " enable backspace in insert mode
