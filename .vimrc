set nocompatible
set nolist

set mouse=a
syntax on

set title
set laststatus=2

"colorscheme default

set number
set relativenumber

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set smartindent

set nowrap

set noswapfile
set nobackup
set undodir=$HOME/.vim/undodir
set undofile

set notermguicolors
"set termguicolors
set t_Co=256

set signcolumn="yes"

set scrolloff=8

set updatetime=50

set colorcolumn="80"

let mapleader=" "

set hlsearch

" ------------------------------------ "
" Autocompletado
set complete+=k/path/to/file

" Achicar cursor y remarcar linea en la que escribo
"autocmd InsertEnter,InsertLeave * set cul!     Otra forma que no me andubo, aveces
                                           " se sale y no anda por alguna razon
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" Arreglar tema de delay cuando salgo del insert
set ttimeout
set ttimeoutlen=1
set ttyfast

nnoremap <Leader>pv :Ex<CR>


nnoremap <leader>h :bprev<CR>
nnoremap <leader>l :bnext<CR>

" Use 'H' and 'L' keys to move to start/end of the line "
nnoremap H ^
nnoremap L $

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <C-j> <C-d>zz
nnoremap <C-k> <C-u>zz
nnoremap n nzz
nnoremap N Nzz

xnoremap <leader>p "_ddP

set clipboard=unnamedplus

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

nnoremap <leader>d "_d
xnoremap <leader>d "_d

nnoremap <leader>s :%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>

