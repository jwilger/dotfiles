"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! MySys()
   return "mac"
   " return "linux"
   " return "windows"
endfun

set history=300
set nocompatible
filetype plugin on
filetype indent on
set autoread " re-read when file changed from the outside
let mapleader = ","
let g:mapleader = ","

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

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
set mat=2 "How many tenths of a second to blink
set noerrorbells " No sound on errors
set novisualbell
set t_vb=
set nu " print line numbers in gutter
set numberwidth=4

" open a new line without entering insert mode
map <Enter> o<ESC>
map <C-p> O<ESC>

imap jj <Esc>
imap hh =>
set showcmd
set nowrap
set linebreak  " Wrap at word
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright
:noremap <leader>v :vsp^M^W^W<cr>
:noremap <leader>h :split^M^W^W<cr>
:noremap <leader>w :wincmd w<cr>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
if MySys() == "mac"
  set gfn=Monaco:h18
  set shell=/bin/zsh
elseif MySys() == "windows"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
  set gfn=Monospace\ 10
  set shell=/bin/zsh
endif

if has("gui_running")
  set guioptions-=T
  set background=dark
  set t_Co=256
  set background=dark
else
  set background=dark
  set t_Co=256 " 256 colors
  set background=dark
endif
colorscheme solarized

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
" Don't allow write-quit command (without a pause, anyway), since 90% of the
" time, it's not what I want to do
noremap :wq :w


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set tw=80
set ai "Auto indent
set si "Smart indet

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader><cr> :noh<cr>

" append a new blank line after the cursor and enter insert mode
map <leader>cx a<cr><ESC>ko

" insert a new blank line before the cursor and enter insert mode
map <leader>x i<cr><ESC>ko

" close the curly brace and be in insert mode on the line between them
inoremap {<CR> {<CR>}<ESC>O

"Quickly open a buffer for scripbble
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

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

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
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving lines up and down
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-j> :m+<CR>k==j==^
nnoremap <C-k> :m-2<CR>j==k==^
inoremap <C-j> <Esc>:m+<CR>k==j==gi
inoremap <C-k> <Esc>:m-2<CR>j==k==gi
vnoremap <C-j> :m'>+<CR>gv
vnoremap <C-k> :m-2<CR>gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated .git'
set grepprg="ack --column"
set grepformat=%f:%l:%c:%m
autocmd FileType qf :map <buffer> <Enter> <Enter>zx

""""""""""""""""""""""""""""""
" => Text files
""""""""""""""""""""""""""""""
autocmd FileType text setlocal textwidth=78
autocmd FileType text :set spl=en_us spell
autocmd FileType gitcommit setlocal textwidth=78
autocmd FileType gitcommit :set spl=en_us spell

""""""""""""""""""""""""""""""
" => HTML files
""""""""""""""""""""""""""""""
autocmd FileType html :set filetype=xhtml " we couldn't care less about html
autocmd FileType html :set spl=en_us spell

""""""""""""""""""""""""""""""
" => Ruby files
""""""""""""""""""""""""""""""
compiler ruby         " Enable compiler support for ruby
autocmd FileType ruby :set foldmethod=syntax
autocmd FileType ruby :set foldlevel=1

""""""""""""""""""""""""""""""
" => Plug-Ins
""""""""""""""""""""""""""""""

" NERD_tree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" Surround
map <leader>" cs'"
map <leader>' cs"'

" ConqueTerm Stuff
autocmd FileType conque_term :set bufhidden=delete
"autocmd FileType conque_term :au BufDelete <buffer> :call QuitTest()
map <F5> :execute 'ConqueTermVSplit zsh'<CR>

function! QuitTest()
  try
    let term = conque_term#get_instance()
    call term.close()
  endtry
endfunction

function! RunTest(focused)
  let filename = expand("%")
  let lineno = line(".")

  if filename =~ ".feature$"
    if a:focused == 1
      let term_command = "cucumber " . filename . ":" . lineno
    else
      let term_command = "cucumber " . filename
    endif
  elseif filename =~ "_spec\.rb$"
    if a:focused == 1
      let term_command = "rspec " . filename . " -l " . lineno
    else
      let term_command = "rspec " . filename
    endif
  elseif filename =~ "\.rb$"
    let term_command = "ruby " . filename
  endif
  let g:ConqueTerm_InsertOnEnter = 1
  call conque_term#open(term_command, ["below split"])
endfunction

nnoremap <Leader>r :call RunTest(1)<CR>
nnoremap <Leader>R :call RunTest(0)<CR>
