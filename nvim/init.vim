set runtimepath^=~/.nvim runtimepath+=~/.nvim/after
let &packpath = &runtimepath

" Package Management
packadd minpac
call minpac#init()
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

call minpac#add('tpope/vim-commentary')
call minpac#add('Shougo/deoplete.nvim')
call minpac#add('Valloric/ListToggle') "toggle quick and location lists
call minpac#add('airblade/vim-gitgutter')
call minpac#add('altercation/vim-colors-solarized')
call minpac#add('andyl/vim-projectionist-elixir')
call minpac#add('c-brenn/phoenix.vim')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('Numkil/ag.nvim')
call minpac#add('janko-m/vim-test')
call minpac#add('jlanzarotta/bufexplorer')
call minpac#add('jreybert/vimagit')
call minpac#add('ngmy/vim-rubocop')
call minpac#add('roxma/nvim-yarp')
call minpac#add('roxma/vim-hug-neovim-rpc')
call minpac#add('scrooloose/nerdtree', {'on': 'NERDTreeToggle'})
call minpac#add('sheerun/vim-polyglot')
call minpac#add('slashmili/alchemist.vim')
call minpac#add('tpope/vim-bundler') "Ruby Bundler support
call minpac#add('tpope/vim-commentary') "toggle comment lines with gc
call minpac#add('tpope/vim-dispatch') "tmux/vim integration
call minpac#add('tpope/vim-endwise') "auto-insert closing 'end' statements
call minpac#add('tpope/vim-eunuch') "Unix file manipulation like :Delete or :Move
call minpac#add('tpope/vim-projectionist') "project config
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rake')
call minpac#add('tpope/vim-rbenv')
call minpac#add('tpope/vim-repeat') "enable . repeating of plugin commands
call minpac#add('tpope/vim-sleuth') "autodetect tab/indent settings
call minpac#add('tpope/vim-surround') "enable cs for change surround
call minpac#add('tpope/vim-unimpaired') "lots of toggles prefixed with [ and ]
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('w0rp/ale')

packloadall

" Leader
let mapleader = " "

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

augroup vimrcElixir
  autocmd!
  autocmd FileType elixir nmap <buffer> <leader>mdo :Dispatch! mix docs && open doc/index.html<CR>
  autocmd FileType elixir nmap <buffer> <leader>mdd :Dispatch! mix docs<CR>
augroup END

augroup vimrcQf
  autocmd!
  autocmd FileType qf set wrap
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=7 " n lines of context above and below the cursor
set sidescrolloff=10
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
set foldlevelstart=100

" open a new line without entering insert mode
map <Enter> o<ESC>
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" The <ESC> key is too hard to reach for accurately on Apple keyboards
imap jk <Esc>

imap fp \|>

set nowrap
set linebreak " Wrap at word

" Make dealing with split windows a little easier
set equalalways " Vertical and horizontal splits default to equal sizes when created
set splitbelow splitright
:noremap <leader>v :vsp<cr> " Quick access to vertical splits
:noremap <leader>h :split<cr> " Quick access to horizontal splits
:noremap <leader>w :wincmd w<cr> " Cycle through windows

" Show buffer list (also mapped to "<leader>be", but this is easier to type
map <leader>bb :BufExplorer<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=1
catch
endtry

map <leader>d :NERDTreeToggle<cr>

augroup ale
  autocmd!
  " ALE linting events
  set updatetime=1000
  let g:ale_lint_on_text_changed = 0
  let g:ale_sign_column_always = 1
  let g:alchemist_tag_disable = 1
  let g:ale_linters = {
        \'elixir': ['credo'],
        \}
  autocmd CursorHold * ALELint
  autocmd CursorHoldI * ALELint
  autocmd InsertEnter * ALELint
  autocmd InsertLeave * ALELint

  " Move between linting errors
  nnoremap ]r :ALENextWrap<CR>
  nnoremap [r :ALEPreviousWrap<CR>
augroup END

let g:lt_location_list_toggle_map = '<leader>ol'
let g:lt_quickfix_list_toggle_map = '<leader>oq'

nnoremap <F8> :Dispatch<CR>

let g:deoplete#enable_at_startup = 1

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

nmap <leader>gi :MagitOnly<CR>
nmap <leader>gp :Dispatch git push --quiet<CR>

nmap <leader>ss :e ~/vim-scratch<CR>

let g:test#strategy = "dispatch"
let g:test#elixir#mix#executable = 'nanobox run mix'

let g:ag_working_path_mode="r"

nmap <leader>oq :QToggle<CR>

nmap <Bslash> :Ag<Space>
nmap <Bslash><Bslash> :AgAdd<Space>

set background=dark
colorscheme solarized
AirlineTheme alduin

highlight SpellCap ctermbg=NONE cterm=underline
highlight Search ctermfg=0 ctermbg=2
highlight ColorColumn ctermbg=18
highlight VertSplit cterm=NONE ctermbg=NONE

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

