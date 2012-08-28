"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" No reason to limit ourselves to vi compatibility
set nocompatible

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

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

" Change <leader>, because commas are easier to reach for than backslashes
let mapleader = ","
let g:mapleader = ","

" Maintain some setup between sessions
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=7 " n lines of context above and below the cursor
set sidescrolloff=10
set cursorline
set cursorcolumn
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
map <C-p> O<ESC>

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
