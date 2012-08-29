"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" No reason to limit ourselves to vi compatibility
set nocompatible

runtime macros/matchit.vim

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" Change <leader>, because commas are easier to reach for than backslashes
let mapleader = ","
let g:mapleader = ","

" Basic setup for pathogen
call pathogen#infect()
syntax on
filetype plugin indent on

" Remember command line entries
set history=300

" Reload files when they are changed by another process.
set autoread
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Maintain some setup between sessions
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=7 " n lines of context above and below the cursor
set sidescrolloff=10
set wildmenu "Turn on WiLd menu
set ruler " Always show current position
set cmdheight=1 "The commandbar height
set hid "Change buffer without saving
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase " Ignore case when searching 
set smartcase " Ignore case when searching lowercase
set hlsearch  " highlight search
set incsearch  " incremental search, search as you type
map <silent> <leader><cr> :noh<cr> " clear search highlighting
set magic " make regular expressions behave sanely (i.e. "." matches any character vs. "\.")
set showmatch "Show matching bracets when text indicator is over them
set noerrorbells " No sound on errors
set novisualbell
set t_vb=
set nu " print line numbers in gutter
set numberwidth=4

" show trailing whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" open a new line without entering insert mode
map <Enter> o<ESC>

" The <ESC> key is too hard to reach for accurately on Apple keyboards
imap jj <Esc>

set showcmd " Defaults to on for vim anyway, but just in case
set nowrap
set linebreak " Wrap at word

" Make dealing with split windows a little easier
set equalalways " Vertical and horizontal splits default to equal sizes when created
set splitbelow splitright
:noremap <leader>v :vsp<cr> " Quick access to vertical splits
:noremap <leader>h :split<cr> " Quick access to horizontal splits
:noremap <leader>w :wincmd w<cr> " Cycle through windows

" Some folks will insist on using the mouse. Let's pick our battles...
if has('mouse')
  set mouse=a
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
set background=dark
colorscheme solarized


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Encoding and locale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf8

try
  lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set tw=72
set ai "Auto indent
set si "Smart indet

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Quickly open a scratch buffer
map <leader>q :e ~/buffer<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Show buffer list (also mapped to "<leader>be", but this is easier to type
map <leader>bb :BufExplorer<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=1
catch
endtry


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Never hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
  let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
  return curdir
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope - for showing and navigating "errors"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

""""""""""""""""""""""""""""""
" => Text files
""""""""""""""""""""""""""""""
autocmd FileType text setlocal textwidth=72
autocmd FileType text setlocal nosi
autocmd FileType text :set spl=en_us spell
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal nosi
autocmd FileType gitcommit :set spl=en_us spell

""""""""""""""""""""""""""""""
" => HTML files
""""""""""""""""""""""""""""""
autocmd FileType html :set spl=en_us spell

""""""""""""""""""""""""""""""
" => Ruby files
""""""""""""""""""""""""""""""
compiler ruby         " Enable compiler support for ruby
autocmd FileType ruby :set foldmethod=syntax
autocmd FileType ruby :set foldlevel=1

""""""""""""""""""""""""""""""
" => Plugin config
""""""""""""""""""""""""""""""
nnoremap <F5> :GundoToggle<CR>
map <leader>d :NERDTree<CR>

" Allow for local customization, but don't error out if file is not
" present
try
  source ~/.vimrc.local
catch
endtry
