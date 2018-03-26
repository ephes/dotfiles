filetype plugin indent on

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
