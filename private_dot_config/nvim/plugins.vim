if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/jochen/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/jochen/.vim/bundles')
  call dein#begin('/Users/jochen/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/jochen/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  " doesn't work, had to add it in nvim_general
  let g:deoplete#enable_at_startup = 1

  call dein#add('zchee/deoplete-jedi')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif
