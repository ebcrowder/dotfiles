" vimrc
" plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" theme
Plug 'tomasiser/vim-code-dark'
" rust
Plug 'rust-lang/rust.vim'
" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'json', 'graphql', 'vue', 'yaml', 'html'] }
" vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" comments, git, text
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Related Configs
"""""""""""""""""""""""""""""""""""""""""""""""
" theme
set t_Co=256
colorscheme codedark 
syntax on

" netrw
map <silent> <C-b> :Lexplore <CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" vim-lsp 
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ })
endif

" ts
if executable('typescript-language-server')
" npm install -g typescript typescript-language-server	
    au User lsp_setup call lsp#register_server({
	\ 'name': 'typescript-language-server',
	\ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
	\ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
	\ 'allowlist': ['typescript', 'typescript.tsx', 'javascript', 'javascript.jsx'],
	\ })
endif

if executable('yaml-language-server')
" npm install -g yaml-language-server	
  augroup LspYaml
   autocmd!
   autocmd User lsp_setup call lsp#register_server({
       \ 'name': 'yaml-language-server',
       \ 'cmd': {server_info->['yaml-language-server', '--stdio']},
       \ 'allowlist': ['yaml', 'yaml.ansible'],
       \ 'workspace_config': {
       \   'yaml': {
       \     'validate': v:true,
       \     'hover': v:true,
       \     'completion': v:true,
       \     'customTags': [],
       \     'schemas': { "kubernetes": "/*" },
       \     'schemaStore': { 'enable': v:true },
       \   }
       \ }
       \})
  augroup END
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gh <plug>(lsp-hover)
    nmap <buffer> <f2> <plug>(lsp-rename)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1 
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 200
let g:lsp_highlight_references_enabled = 1
let g:lsp_signs_error = {'text': '✗'}

" rust 
let g:rustfmt_autosave = 1

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_command = 'gopls'
let g:go_gopls_staticcheck = 1

" prettier 
let g:prettier#quickfix_enabled = 0
let g:prettier#exec_cmd_async = 1

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

"statusline 
set laststatus=2
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}]
set statusline+=\ %p%%
set statusline+=\ %l:%c
