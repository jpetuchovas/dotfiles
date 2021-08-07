call plug#begin('~/.vim/plugged')
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tomasiser/vim-code-dark'
call plug#end()

filetype plugin indent on
set autoindent
set autoread
set backspace=2
set colorcolumn=81
set cursorline
set expandtab
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nojoinspaces
set number
set relativenumber
set shiftwidth=2
set showtabline=2
set smartcase
set softtabstop=2
set tabstop=2
set wildmenu
set wildmode=longest,list
syntax on

autocmd FileType gitcommit set colorcolumn=51,73 textwidth=72
autocmd FileType python set colorcolumn=73,89 shiftwidth=4 softtabstop=4

colorscheme codedark
