""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Godwin Pang - github: @godwinpang
" vimrc setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug Plugin Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $HOME/.vimrc
endif

call plug#begin('~/.vim/plugged')
" For Looks
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Utils
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-commentary'
Plug 'townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

" Go
Plug 'fatih/vim-go'

" Web
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}


Plug 'vim-python/python-syntax'
call plug#end()
set path+=**

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "

" Sets number of lines of history vim has to remember
set history=500

" Enable filetype plugins
filetype indent plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set minimum space above and below cursor
set scrolloff=5

" Set line numbers
set relativenumber
set number

" Command autocompletion settings
set wildmenu " enable command autocompletion
set wildignore=*.o,*~,*.class,*/git,*/.DS_Store

" Always show current position
set ruler      " show line and char num
set cursorline " horizontal line on cursor

" Always show status line
set laststatus=2

" Set backspace to act like standard text editor
set backspace=indent,eol,start

" Set h l and arrow keys to wrap at end of line
set whichwrap+=<,>,h,l

" Search settings
set ignorecase " set search to be case insensitive
set smartcase " set search to be case sensitive when item has upper case letter
set incsearch " searches as editing search item

" Highlight matching brackets
set showmatch

" Error settings
set noerrorbells " turn off error sounds
set novisualbell " turn off error flash
set t_vb= " turn off error flash

" Don't redraw when executing macros
set lazyredraw

" Remove mode (shown in lightline anyways)
set noshowmode

set encoding=UTF-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight keywords in language
syntax enable

" 80 char line length
match Error /\%101v.\+/ " Highlight chars over 80
set colorcolumn=100 " Column at 80 chars

" Colorscheme
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

" Enable 256 colors palette
set t_Co=256

" Background
set background=dark

set guifont=Inconsolata-g\ for\ Powerline\ 18

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Swap files are annoying
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabbing """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Set tab to 4 spaces
set shiftwidth=4
set tabstop=4

autocmd FileType yml setlocal tabstop=2 shiftwidth=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 shiftwidth=2

" Indentation
set autoindent " maintain indentation on newline

" Wrapping text
set textwidth=100 " Set length to wrap at
set linebreak     " Set wrap to insert linebreak

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving Around
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For mouse normies like me
set mouse=a

" Mapping to move around windows
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Maintain column selection when moving around
set nostartofline

" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.h,*.c,*.java,*.vimrc,*.txt,*.js,*.py,*.go,*.ts,*.tsx :call CleanExtraSpaces()
endif

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folds Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set foldmethod=syntax
set foldlevelstart=20
nmap z za

vnoremap < <gv
vnoremap > >gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lightline Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              ['fileformat', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coc Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=300
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-eslint', 'coc-go',
                              \ 'coc-yaml', 'coc-json', 'coc-prettier']

nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>do <Plug>(coc-codeaction)

" Get definition in hover box
nnoremap <silent> <Leader>d :silent! call CocActionAsync('doHover')<CR>

" Use <tab> for completion navigation
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use enter to complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdTree Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent><Leader>n :NERDTreeToggle<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/usr/local/bin/zsh
set termwinsize=10x0
map <silent><Leader>t :belowright terminal<CR>
tnoremap <Esc> <C-\><C-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Undotree Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent><Leader>u :UndotreeToggle<CR>

" IDK why I can't copy
vmap <C-c> :w !pbcopy<CR><CR>
