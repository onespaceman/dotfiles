let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set bg=dark

syntax on
filetype indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set showcmd
set cursorline
set lazyredraw
set showmatch
set backup
set backupdir=/tmp
set clipboard+=unnamedplus


" vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'morhetz/gruvbox'
Plug 'ervandew/supertab'

call plug#end()


" airline
let g:airline_theme = 'gruvbox'
set laststatus=2
let g:airline_powerline_fonts = 1
