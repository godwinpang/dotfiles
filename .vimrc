""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Godwin Pang - github: @godwinpang
" vimrc setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle Plugin Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required
"
" " set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/goyo.vim'
Plugin 'morhetz/gruvbox'
Plugin 'airblade/vim-gitgutter'
Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets number of lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight keywords in language
syntax enable

" 80 char line length
match Error /\%81v.\+/ " Highlight chars over 80
set colorcolumn=80 " Column at 80 chars

" Colorscheme
colorscheme gruvbox

" Enable 256 colors palette
set t_Co=256

" Background
set background=dark


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn backup off because git is superior (NOT RECOMMENDED)
" set nobackup
" set noswapfile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabbing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Set tab to 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Indentation
set autoindent " maintain indentation on newline
set smartindent " insert new indentation if needed

" Wrapping text
set textwidth=80 " Set length to wrap at
set linebreak    " Set wrap to insert linebreak
if has('autocmd')
    autocmd FileType * setlocal formatoptions+=t " overrides filetype plugin
                                                 " format options setting
endif


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
    autocmd BufWritePre *.h,*.c,*.java,*.vimrc,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.ino,*cs :call CleanExtraSpaces()
endif

" Save upon losing focus
au FocusLost * :wa

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
" => Syntastic Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

" create functions for automatic header insertion.

" Function for setting up C/C++ file headers
function FileHeadingC()
  let s:line=line(".")
  call setline(s:line, "/*-----------------------------------------------------------------------------")
  call append(s:line, "")
  call append(s:line+1, "                                                        Godwin Pang")
  call append(s:line+2, "                                                        " .strftime("%d %b %Y"))
  call append(s:line+3, "                                                        cs12xfu")
  call append(s:line+4,"                                    Homework X")
  call append(s:line+5, "")
  call append(s:line+6, "File Name:       " .expand("%"))
  call append(s:line+7, "Description:     TODO")
  call append(s:line+8, "-----------------------------------------------------------------------------*/")
  unlet s:line
endfunction

" Function for setting up C/C++ struct/class headers
function StructHeading()
  let s:line=line(".")
  call setline(s:line, "/*=============================================================================")
  call append(s:line, "/ struct/class XXX add struct/class name here XXX")
  call append(s:line+1, "/")
  call append(s:line+2, "/ Description: TODO")
  call append(s:line+3, "/")
  call append(s:line+4, "/ Data Fields: TODO")
  call append(s:line+5, "/")
  call append(s:line+6, "/ Public Functions:")
  call append(s:line+7, "/ TODO")
  call append(s:line+8,"/============================================================================*/")
  unlet s:line
endfunction

" Function for setting up C/C++ function headers
function FunctionHeading()
  let s:line=line(".")
  call setline(s:line, "/*-----------------------------------------------------------------------------")
  call append(s:line,   "* Function Name:  TODO")
  call append(s:line+1, "* Purpose:        TODO")
  call append(s:line+2, "*")
  call append(s:line+3, "* Description:    TODO")
  call append(s:line+4, "*")
  call append(s:line+5, "* Input:          TODO")
  call append(s:line+6, "* Output:         TODO")
  call append(s:line+7, "* Result:         TODO")
  call append(s:line+8, "*")
  call append(s:line+9, "* Side Effects:   TODO")
  call append(s:line+10, "-----------------------------------------------------------------------------*/")
  unlet s:line
endfunction

" Map the functions to keys for usage
vmap <C-c> :w !pbcopy<CR><CR>
nnoremap <F8> mz:execute FileHeadingC()<CR>`zj
nnoremap <F9> mz:execute StructHeading()<CR>`zj
nnoremap <F10> mz:execute FunctionHeading()<CR>`zj

