" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" jedi
Plugin 'davidhalter/jedi-vim'

" supertab
Plugin 'ervandew/supertab'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" deoplete
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'roxma/nvim-yarp'
Plugin 'shougo/deoplete.nvim'

" black
Plugin 'ambv/black'

" make vim indent only 4 spaces instead of 8
" Plugin 'Vimjas/vim-python-pep8-indent'

" javascript indent
Plugin 'pangloss/vim-javascript'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" make vim use 4 spaces instead of tabs
set tabstop=4
set shiftwidth=4
set expandtab

" overwrite tabstop=8 setting from python.vim
autocmd FileType python setlocal tabstop=4

" enable syntax highlighting
syntax on
set background=dark

" encrypted files
set cm=blowfish2

" set/unset paste mode with <F2>
set pastetoggle=<F2>

" jedi
let g:jedi#auto_initialization = 1

" youcompleteme
let g:ycm_python_binary_path = '/usr/local/bin/python3'
set encoding=utf-8

" deoplete
let g:deoplete#enable_at_startup = 1

" javascript indent
autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab
