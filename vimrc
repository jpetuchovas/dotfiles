call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark'
call plug#end()

filetype plugin indent on
set autoindent
set backspace=2
set colorcolumn=50,72
set cursorline
set expandtab
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set number
set relativenumber
set shiftwidth=2
set showtabline=2
set smartcase
set softtabstop=2
set tabstop=2
syntax on

autocmd FileType python set sw=4 sts=4 et

colorscheme codedark
