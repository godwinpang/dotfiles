" clone link for vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tomtom/tcomment_vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set softtabstop=4
set tabstop=4
set shiftwidth=4
set noexpandtab
set shiftround
syntax on
match Error /\%81v.\+/
set number
set cursorline
set autoindent
set smartindent
set showmatch
set noerrorbells
set novisualbell
set textwidth=80
set colorcolumn=80
set nostartofline
set nojoinspaces
set ignorecase
set smartcase
set relativenumber
set mouse=a
set ruler
set cursorline
set wrap
set showcmd
colorscheme elflord
