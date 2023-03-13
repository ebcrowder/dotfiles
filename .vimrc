" legacy .vimrc

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sensible'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
call plug#end()

" general
set number
set relativenumber
set hidden
set showcmd
set noswapfile
set showmatch
set signcolumn=number

" fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
nnoremap <silent><nowait> <space>f  :<C-u>Files<cr>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)
nnoremap <silent><nowait> <space>g  :<C-u>Rg<cr>

" nord
let g:nord_uniform_diff_background = 1

" colorscheme
set termguicolors
colorscheme nord
let &t_ut=''

" airline config
" disable patched font symbols
let g:airline_symbols_ascii = 1

" ale
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_fixers = {
\	'javascript': ['prettier'], 
\	'typescript': ['prettier'], 
\	'javascriptreact': ['prettier'], 
\	'typescriptreact': ['prettier']
\}
let g:ale_linters = {
\	'javascript': ['tsserver','eslint'], 
\	'typescript': ['tsserver','eslint'], 
\	'javascriptreact': ['tsserver', 'eslint'], 
\ 	'typescriptreact': ['tsserver','eslint']
\}
nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gh <Plug>(ale_hover)
nmap <silent> rn <Plug>(ale_rename)
nmap <silent> rn <Plug>(ale_rename)
nmap <silent> ca <Plug>(ale_code_action)
nmap <silent> [d <Plug>(ale_previous)
nmap <silent> ]d <Plug>(ale_next)
