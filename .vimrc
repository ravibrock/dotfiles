" Vim-plug initialization
call plug#begin()
    " Active plugins
        Plug 'airblade/vim-gitgutter'  " Adds Git diff markers
        Plug 'aymericbeaumet/vim-symlink'  " Opens symlinks in their targets
        Plug 'github/copilot.vim'  " Adds GitHub Copilot support
        Plug 'lervag/vimtex'  " Adds support for LaTeX
        Plug 'majutsushi/tagbar'  " Adds support for viewing tags
        Plug 'neoclide/coc.nvim', { 'branch': 'release' }  " Adds things like IDE variables
        Plug 'nvim-zh/better-escape.vim'  " Improves keybinds for escaping insert mode
        Plug 'scrooloose/nerdtree'  " Adds support for a file tree
        Plug 'turbio/bracey.vim'  " Adds support for live HTML preview
        Plug 'tmsvg/pear-tree'  " Automatically pairs parentheses etc.
        Plug 'tpope/vim-commentary'  " Improves commenting/uncommenting lines
        Plug 'tpope/vim-fugitive'  " Adds Git support
        Plug 'tpope/vim-surround'  " Adds support for surrounding text
        Plug 'vim-airline/vim-airline'  " Improves status bar
        Plug 'vim-airline/vim-airline-themes'  " Adds themes for vim-airline
        Plug 'dense-analysis/ale'  " Adds support for asynchronous linting

    " Inactive plugins
        " Plug 'scrooloose/syntastic'  " Adds syntax checking
        " Plug 'szw/vim-tags'  " Adds support for ctags
        " Plug 'Yggdroot/indentLine'  " Adds support for indent guides
call plug#end()

" Airline config
let g:airline_section_z = airline#section#create(['%l/%L %p%%'])
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = ''
let airline#extensions#ale#warning_symbol = ''
let airline#extensions#ale#show_line_numbers = 1
let airline#extensions#ale#open_lnum_symbol = ' (L'
let airline#extensions#ale#close_lnum_symbol = ')'
let g:airline_theme = 'lessnoise'
" let g:airline_theme = 'lighthaus'
" let g:airline_theme = 'fruit_punch'
" let g:airline_theme = 'cyberpunk'
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ }

" Bracey config
map <silent> <leader>bb :Bracey <CR>

" Coc config
imap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<Plug>(PearTreeExpand)"
imap <C-J> <C-N>
imap <C-K> <C-P>

" Fugitive config
map <silent> <C-g> :Gwrite \| <CR> \| :G commit <CR>

" Gitgutter config
highlight! link SignColumn LineNr
set signcolumn=yes

" IndentLine config
let g:indentLine_char = '│'

" NERDTree config
let g:NERDTreeWinSize=45
map <silent> <C-o> :NERDTreeToggle <CR>

" PearTree config
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" Syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Tagbar config
map <silent> <C-t> :TagbarToggle <CR>

" Disable vi compatibility
set nocompatible

" Map the leader key to a spacebar
map <Space> <leader>

" Configure working directory
autocmd BufEnter * lcd %:p:h

" Stops comments from being extended to newlines
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

" History
set history=100

" Filetype plugins
filetype on
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

" Show current file and status bar
set title
set titlestring=%F\ %r\ %m
set laststatus=2

" Line numbers
set number
set relativenumber

" Syntax highlighting
syntax enable
hi MatchParen cterm=none ctermbg=white ctermfg=black
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

" Backup
set nobackup
set nowb
set noswapfile

" Shows commands
set showcmd

" Remapping
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Remove trailing whitespace on save
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
