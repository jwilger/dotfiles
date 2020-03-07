scriptencoding utf-8

" ============================================================================ "
" ===                          PLUGIN MANAGEMENT                           === "
" ============================================================================ "
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/jwilger/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/jwilger/.cache/dein')
  call dein#begin('/home/jwilger/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/jwilger/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  call dein#add('Shougo/denite.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('elixir-editors/vim-elixir')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('Valloric/ListToggle') "toggle quick and location lists
  call dein#add('airblade/vim-gitgutter')
  call dein#add('jreybert/vimagit')
  call dein#add('kburdett/vim-nuuid')
  call dein#add('scrooloose/nerdtree', {'on': 'NERDTreeToggle'})
  call dein#add('tpope/vim-commentary') "toggle comment lines with gc
  call dein#add('tpope/vim-endwise') "auto-insert closing 'end' statements
  call dein#add('tpope/vim-eunuch') "Unix file manipulation like :Delete or :Move
  call dein#add('tpope/vim-repeat') "enable . repeating of plugin commands
  call dein#add('tpope/vim-sleuth') "autodetect tab/indent settings
  call dein#add('tpope/vim-surround') "enable cs for change surround
  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Remap leader key to ,
let g:mapleader=' '

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Yank and paste with the system clipboard
set clipboard=unnamed

" Hides buffers instead of closing them
set hidden

" Use one space, not two, after punctuation.
set nojoinspaces

" === TAB/Space settings === "
  " Insert spaces when TAB is pressed.
  set expandtab

  " Change number of spaces that a <Tab> counts for during editing ops
  set softtabstop=2

  " Indentation amount for < and > commands.
  set shiftwidth=2

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline


" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" === Denite setup ==="
  " Wrap in try/catch to avoid errors on initial install before plugin is available
  try
    " Use ripgrep for searching current directory for files
    " By default, ripgrep will respect rules in .gitignore
    "   --files: Print each file that would be searched (but don't search)
    "   --glob:  Include or exclues files for searching that match the given glob
    "            (aka ignore .git files)
    "
    call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

    " Use ripgrep in place of "grep"
    call denite#custom#var('grep', 'command', ['rg'])

    " Custom options for ripgrep
    "   --vimgrep:  Show results with every match on it's own line
    "   --hidden:   Search hidden directories and files
    "   --heading:  Show the file name above clusters of matches from each file
    "   --S:        Search case insensitively if the pattern is all lowercase
    call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

    " Recommended defaults for ripgrep via Denite docs
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " Remove date from buffer list
    call denite#custom#var('buffer', 'date_format', '')

    " Custom options for Denite
    "   auto_resize             - Auto resize the Denite window height automatically.
    "   prompt                  - Customize denite prompt
    "   direction               - Specify Denite window direction as directly below current pane
    "   winminheight            - Specify min height for Denite window
    "   highlight_mode_insert   - Specify h1-CursorLine in insert mode
    "   prompt_highlight        - Specify color of prompt
    "   highlight_matched_char  - Matched characters highlight
    "   highlight_matched_range - matched range highlight
    let s:denite_options = {'default' : {
    \ 'split': 'floating',
    \ 'start_filter': 1,
    \ 'auto_resize': 1,
    \ 'source_names': 'short',
    \ 'prompt': 'λ ',
    \ 'highlight_matched_char': 'QuickFixLine',
    \ 'highlight_matched_range': 'Visual',
    \ 'highlight_window_background': 'Visual',
    \ 'highlight_filter_background': 'DiffAdd',
    \ 'winrow': 1,
    \ 'vertical_preview': 1
    \ }}

    " Loop through denite options and enable them
    function! s:profile(opts) abort
      for l:fname in keys(a:opts)
        for l:dopt in keys(a:opts[l:fname])
          call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
        endfor
      endfor
    endfunction

    call s:profile(s:denite_options)
  catch
    echo 'Denite not installed. It should work after running :PlugInstall'
  endtry

" === Coc.nvim === "
  " use <tab> for trigger completion and navigate to next complete item
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  "Close preview window when completion is done.
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === nuuid === "
let g:nuuid_iabbrev = 1

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
set termguicolors

"Sometimes setting 'termguicolors' is not enough and one has to set the t_8f and t_8b options explicitly
":h xterm-true-color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Vim airline theme
let g:airline_theme='nord'

" Change vertical split character
set fillchars+=vert:.

" maintain context around cursor
set scrolloff=7
set sidescrolloff=10

" Set preview window to appear at bottom
set splitbelow
set splitright

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" Make it obvious where 98 characters is
set textwidth=98
set colorcolumn=+1

" Enable line numbers
set number
set numberwidth=5

" === Completion Settings === "

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" ============================================================================ "
" ===                      CUSTOM COLORSCHEME CHANGES                      === "
" ============================================================================ "

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" Editor theme
set background=dark
try
  colorscheme nord
catch
  colorscheme slate
endtry

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" === coc.nvim === "
  "   <leader>dd    - Jump to definition of current symbol
  "   <leader>dr    - Jump to references of current symbol
  "   <leader>dj    - Jump to implementation of current symbol
  "   <leader>ds    - Fuzzy search current project symbols
  nmap <silent> <leader>dd <Plug>(coc-definition)
  nmap <silent> <leader>dr <Plug>(coc-references)
  nmap <silent> <leader>dj <Plug>(coc-implementation)
  nnoremap <silent> <leader>ds :<C-u>CocList -I -N --top symbols<CR>

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" open a new line without entering insert mode
map <Enter> o<ESC>

" The <ESC> key is too hard to reach for accurately on Apple keyboards
imap jk <Esc>

imap fpp \|>
imap bpp <\|

" Make dealing with split windows a little easier
set equalalways " Vertical and horizontal splits default to equal sizes when created
:noremap <leader>v :vsp<cr> " Quick access to vertical splits
:noremap <leader>h :split<cr> " Quick access to horizontal splits
:noremap <leader>w :wincmd w<cr> " Cycle through windows

map <leader>d :NERDTreeToggle<cr>

nmap <leader>gi :MagitOnly<CR>
nmap <leader>gp :Dispatch git push --quiet<CR>

nmap <leader>ss :e ~/vim-scratch<CR>
" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" preserve undo history across restarts
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set noswapfile

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set hlsearch  " highlight search
set incsearch  " incremental search, search as you type
map <silent> <leader><cr> :noh<cr> " clear search highlighting
set magic " make regular expressions behave sanely (i.e. "." matches any character vs. "\.")
set showmatch "Show matching bracets when text indicator is over them
set noerrorbells " No sound on errors
set novisualbell
set t_vb=

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=1
catch
endtry

" Mkdir on save for new directories
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical
