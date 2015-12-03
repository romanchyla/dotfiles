" Installationn Instructions
"	1. Place file in home directory as .vimrc
"	2. Run the following command in terminal
"		curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"	3. Launch Vim and Run
"		:PlugInstall
"	5. Restart Vim

set nocompatible
" autoload the changes from disk
set autoread
au CursorHold,CursorHoldI * silent! checktime
" copy into system clipboard
set clipboard=unnamedplus

" ----------------- key mappings -------------------------------------

ino jk <ESC>
let mapleader = "\<Space>"
nnoremap <F5> :buffers<CR>:buffer<Space>

" Edit .vimrc  \v
nmap <leader>v :edit $MYVIMRC<CR>
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" inoremap jk <ESC>
let mapleader = "\<Space>"

set encoding=utf-8

"---------------------Plugins ----------------------------------------

call plug#begin()
" documentation:
" https://github.com/junegunn/vim-plug

Plug 'shemerey/vim-peepopen'
Plug 'junegunn/vim-easy-align'

" ----- Making Vim look good ------------------------------------------
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'bling/vim-airline'

" ----- Vim as a programmer's text editor -----------------------------
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/syntastic'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
" installation: git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ~/.fzf/install
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" ----- Plugin-Specific Settings --------------------------------------

" ----- altercation/vim-colors-solarized settings -----
set background=dark
"let g:solarized_termcolors=256
colorscheme solarized

" ----- bling/vim-airline settings -----
" Always show statusbar
set laststatus=2
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1

" ----- jistr/vim-nerdtree-tabs -----
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0


" ----- scrooloose/syntastic settings -----
augroup mySyntastic
  au!
au FileType tex let b:syntastic_mode = "passive"
augroup END
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1


" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
"

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


