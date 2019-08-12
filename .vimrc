" Installationn Instructions
"	1. Place file in home directory as .vimrc
"	2. Run the following command in terminal
"		curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"	3. Launch Vim and Run
"		:PlugInstall
"	5. Restart Vim

set nocompatible
set encoding=utf-8

" autoload the changes from disk
set autoread
au CursorHold,CursorHoldI * silent! checktime
" copy into system clipboard
set clipboard=unnamedplus

" size of a hard tabstop
set tabstop=2

" size of an "indent"
set shiftwidth=2

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

" ----------------- key mappings -------------------------------------

ino jk <ESC>
let mapleader = "\<Space>"
nnoremap <F5> :buffers<CR>:buffer<Space>

" Edit .vimrc  \v
nmap <leader>v :edit $MYVIMRC<CR>
" Open/close tagbar with \a
nmap <silent> <leader>a :TagbarToggle<CR>
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" inoremap jk <ESC>

nmap <silent> <leader>f :BLines<CR>
nmap <silent> <leader>h :Lines<CR>
nmap <silent> <leader>b :Buffers<CR>

nmap <silent><leader>n :tabnext<CR>
nmap <silent><leader>N :tabprev<CR>
"---------------------Plugins ----------------------------------------

" ---------------- vim settings ----------------------
filetype plugin indent on

set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch
set hidden " dont bother with unsaved buffers
syntax on

set mouse=a


