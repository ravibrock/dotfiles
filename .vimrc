" Vim-plug initialization
call plug#begin()
    Plug 'airblade/vim-gitgutter'  " Adds Git diff markers
    Plug 'aymericbeaumet/vim-symlink'  " Opens symlinks in their targets
    Plug 'github/copilot.vim'  " Adds GitHub Copilot support
    Plug 'jez/vim-superman'  " Adds support for calling man pages in vim
    Plug 'jistr/vim-nerdtree-tabs'  " Adds support for tabs in NERDTree
    Plug 'majutsushi/tagbar'  " Adds support for viewing tags
    Plug 'nathanaelkane/vim-indent-guides'  " Adds indentation guides
    Plug 'scrooloose/nerdtree'  " Adds support for a file tree
    Plug 'scrooloose/syntastic'  " Adds syntax checking
    Plug 'szw/vim-tags'  " Adds support for ctags
    Plug 'tmsvg/pear-tree'  " Automatically pairs parentheses etc.
    Plug 'tpope/vim-commentary'  " Improves commenting/uncommenting lines
    Plug 'tpope/vim-fugitive'  " Adds Git support
call plug#end()

" Disable vi compatibility
set nocompatible

" Stops comments from being extended to newlines
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

" Configure syntax checking
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" History
set history=100

" Filetype plugins
filetype plugin on
filetype indent on

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Text encoding
set encoding=utf8

" Filetype
set ffs=unix,dos,mac

" Spaces vs. tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Show current position
set laststatus=1

" Show current file
set title
set titlestring=%F\ %r\ %m

" Enable line numbers and relative numbering
set number
set relativenumber 

" Syntax highlighting
syntax enable
highlight LineNr ctermfg=grey

" Show matching brackets
set showmatch
set mat=2

" Enables yank to system clipboard, use `unnamedplus` if broken on Linux
set clipboard=unnamed

" Return to last cursor position when reopening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Disable bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Configure search
set ignorecase
set smartcase
set incsearch
set magic
nnoremap <CR> :noh<CR><CR>:<backspace>

" Mouse support (depends on terminal)
set mouse+=a

" Enable hidden buffers
set hidden

" Regex
set regexpengine=0

" Visual mode searching for current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> " :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Don't redraw
set lazyredraw

" Enable autoread
set autoread
au FocusGained,BufEnter * checktime

" Adjust gitgutter appearance to linenumber column
highlight! link SignColumn LineNr

" Backup
set nobackup
set nowb
set noswapfile

" Shows commands
set showcmd

" Remapping
map 0 ^
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif
