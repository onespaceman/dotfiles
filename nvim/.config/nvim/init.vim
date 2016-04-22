" theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:gruvbox_italics=1
colorscheme custom
set bg=dark

" mappings
map <Space> :
cabbrev Wq wq
cabbrev W w
cabbrev Q q
let mapleader = ","
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tabs and spaces
filetype indent on " load filetype-specific indent files
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4
set expandtab " tabs are spaces
set smartindent

" gui options
set number " show line numbers
set relativenumber " show relative line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set lazyredraw " redraw only when we need to
set noshowmode " don't show mode below statusline
set title " window title
set titlestring=nvim\ %(\ %f\ %M%)

" search
set showmatch " highlight matching
set ignorecase " match upper and lowercase in search

" folds
set foldlevelstart=10 " open most folds by default
set foldnestmax=10  " 10 nested fold max
set foldmethod=indent " fold based on indent level

" extra
set backup
set backupdir=$XDG_DATA_HOME/nvim/backup,/tmp
set undofile
set hidden

" splits
set splitbelow
set splitright

" improve startup time
let g:python_host_skip_check=1
let g:loaded_python_provider=1
let g:loaded_python3_provider=1

" vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'morhetz/gruvbox'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/Colorizer'
Plug 'fatih/vim-go'

call plug#end()

" lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'right': [ [ 'syntastic', 'lineinfo' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"\ue0a2":""}',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_stl_format='err: %F (%t)'

" Better Buffer Navigation {{{
" Maps <Tab> to cycle though buffers but only if they're modifiable.
" If they're unmodifiable it maps <Tab> to cycle through splits.

function! BetterBufferNav(bcmd)
	if &modifiable == 1 || &ft == 'help'
		execute a:bcmd
	else
		wincmd w
	endif
endfunction

" Maps Tab and Shift Tab to cycle through buffers
nmap <silent> <Tab> :call BetterBufferNav("bn") <Cr>
nmap <silent> <S-Tab> :call BetterBufferNav("bp") <Cr>

" }}}

" Quick Terminal {{{
" Spawns a terminal in a small split for quick typing of commands
" Also maps <Esc> to quit out of the terminal

function QuitTerminal()
	setlocal buflisted
	silent! bd! quickterm
	silent! bd! term://*//*/home/dyl/.fzf/bin/fzf*
endfunction

function! QuickTerminal()
	10new
	terminal
	file quickterm
endfunction

tnoremap <silent> <Esc> <C-\><C-n>:call QuitTerminal()<CR>
nnoremap <silent> <Leader>t :call QuickTerminal()<CR>

" }}}
