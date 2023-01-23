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

" Show current position
set ruler

" Configure search
set ignorecase
set smartcase
set magic

" Don't redraw
set lazyredraw

" Show matching brackets
set showmatch
set mat=2

" Disable bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Enable line numbers
set number

" Enable autoread
set autoread
au FocusGained,BufEnter * checktime

" Syntax highlighting
syntax enable
highlight LineNr ctermfg=grey

" Return to last cursor position when reopening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Regex
set regexpengine=0

" Text encoding
set encoding=utf8

" Filetype
set ffs=unix,dos,mac

" Bacup
set nobackup
set nowb
set noswapfile

" Spaces vs. tabs
set expandtab

" Visual mode searching for current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> " :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

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

