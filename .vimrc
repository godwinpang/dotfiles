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

" Go
Plug 'fatih/vim-go'

" Web
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'vim-python/python-syntax'
call plug#end()
set path+=**

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "

" Sets number of lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype indent plugin on

" Set to autoread when file is changed from outside
set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set minimum space above and below cursor
set scrolloff=5

" Set line numbers
set relativenumber

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
" set hlsearch " highlights search results
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

" Enable 256 colors palette
set t_Co=256

" Background
set background=dark

set guifont=Inconsolata-g\ for\ Powerline\ 18

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn backup off because git is superior (NOT RECOMMENDED)
" set nobackup
" set noswapfile


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
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
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

nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

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

nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>do <Plug>(coc-codeaction)

nnoremap <silent> <Leader>d :silent! call CocActionAsync('doHover')<CR>

" use <tab> for trigger completion and navigate to the next complete item
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdTree Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-t> :botright terminal zsh<CR>

vmap <C-c> :w !pbcopy<CR><CR>

map <C-u> :UndotreeToggle<CR>
