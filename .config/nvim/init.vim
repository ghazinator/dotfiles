set nocompatible
syntax enable
filetype plugin indent on

set expandtab ts=4 sw=4
set ignorecase incsearch
set noswapfile
set scrolloff=5 mouse=ni
set wildmenu wildoptions=pum

call plug#begin()
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-commentary'
call plug#end()

set termguicolors
colorscheme habamax
highlight ModeMsg guibg=NONE guifg=#87AF87
highlight Visual guifg=NONE guibg=#404040
highlight MatchParen guifg=NONE guibg=#404040 cterm=bold
let g:netrw_banner=0

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <tab> :bn <CR>
nnoremap <s-tab> :bp <CR>
nnoremap <C-n> :set nonu! nornu! <CR>
autocmd InsertEnter,WinLeave * if &number | set nornu | endif
autocmd InsertLeave,WinEnter * if &number | set rnu | endif
