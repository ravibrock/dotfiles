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
set cursorline
highlight LineNr ctermfg=grey
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLineNr cterm=bold ctermbg=NONE ctermfg=white

" Syntax highlighting
syntax enable
highlight MatchParen cterm=none ctermbg=white ctermfg=black

" Show matching brackets
set showmatch
set mat=2

" Enables yank to system clipboard, use `unnamedplus` if broken on Linux
set clipboard=unnamed

" IntelliJ integration
set clipboard^=ideaput
set ideajoin

" Return to last cursor position when reopening file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Disable bells
set visualbell
set noerrorbells
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
autocmd FocusGained,BufEnter * checktime

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

" Follow symlinks to target
function! MyFollowSymlink(...)
    if exists('w:no_resolve_symlink') && w:no_resolve_symlink
        return
    endif
    let fname = a:0 ? a:1 : expand('%')
    if fname =~ '^\w+:\/'  " Don't mess with 'fugitive://' etc.
        return
    endif
    let fname = simplify(fname)
    let resolvedfile = resolve(fname)
    if resolvedfile == fname
        return
    endif
    let resolvedfile = fnameescape(resolvedfile)
    echohl WarningMsg | echomsg 'Resolved symlink' fname '-->' resolvedfile | echohl None
    exec 'file ' . resolvedfile
    silent! w!  " Workaround for 'file exists' error on write
endfunction
command! FollowSymlink call MyFollowSymlink()
command! ToggleFollowSymlink let w:no_resolve_symlink = !get(w:, 'no_resolve_symlink', 0) | echo "w:no_resolve_symlink =>" w:no_resolve_symlink
autocmd BufReadPost * call MyFollowSymlink(expand('<afile>'))

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
