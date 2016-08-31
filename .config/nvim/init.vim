" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" ================ General Config ====================


set shell=/bin/zsh                          " Setting shell to zsh
set number                                  " Line numbers on
set showmode                                " Always show mode
set textwidth=120                           " Text width is 120 characters
set cmdheight=1                             " Command line height
set pumheight=10                            " Completion window max size
set timeoutlen=300                          " ESC timeout
set hidden                                  " Enables to switch between unsaved buffers and keep undo history
set clipboard+=unnamed                      " Allow to use system clipboard
set lazyredraw                              " Don't redraw while executing macros (better performance)
set showmatch                               " Show matching brackets when text indicator is over them
set matchtime=2                             " How many tenths of a second to blink when matching brackets
set nostartofline                           " Prevent cursor from moving to beginning of line when switching buffers
set virtualedit=block                       " To be able to select past EOL in visual block mode
set nojoinspaces                            " No extra space when joining a line which ends with . ? !
set scrolloff=5                             " Scroll when closing to top or bottom of the screen
set updatetime=1000                         " Update time used to create swap file or other things
set noswapfile
set mouse=

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader="\<space>"

" =============== plugInitialization ===============

source ~/.config/nvim/plug.vim



" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo//
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set nohlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

"================= Remaps ===========================

" Real Regex instead of vims
nnoremap / /\v
vnoremap / /\v

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Edit the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
"
" Quick replay q macro
nnoremap Q @q

"faster scrolling
noremap j gj
noremap k gk
nnoremap gj 5j
nnoremap gk 5k

"yank to different reg when changing
nnoremap c "xc
xnoremap c "xc

" After block yank and paste, move cursor to the end of operated text
" Also, don't copy over-pasted text in visual mode
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

" No more accidentally showing up command window (Use C-f to show it)
map q: :q

" Use CamelCaseMotion instead of default motions
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" Fix the cw at the end of line bug
" default vim has special treatment (:help cw)
nmap cw ce
nmap dw de

" Yank and paste from clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy
nnoremap <leader>p "+p



" NERDTree wrapper
nnoremap <silent> <F1> :call utils#nerdWrapper()<CR>
" Caps lock mode toggling
nnoremap <silent> <F2> :execute "normal \<Plug>CapsLockToggle"<CR>
" Paste mode toggling
nnoremap <silent> <F3> :set paste!<CR> :set paste?<CR>
" Toggle spelling on and off
nnoremap <silent> <F4> :set spell!<CR> :set spell?<CR>
" Source (reload configuration)
nnoremap <silent> <F5> :source $MYVIMRC<CR>
" Toggle search highlight
nnoremap <silent> <F6> :set nohlsearch!<CR> :set nohlsearch?<CR>
" Toggle white characters visibility
nnoremap <silent> <F7> :set list!<CR> :set list?<CR>
" New horizontal term buffer
nnoremap <silent> <F8> :call utils#newVertTerm()<CR>
" Free
" nnoremap <silent> <F9> :Command<CR>
" Free
" nnoremap <silent> <F10> :Command<CR>
" Free
" nnoremap <silent> <F11> :Command<CR>
" Echo out toggles legend on <F12>
nnoremap <F12> :call utils#showToggles()<CR>


"buffer management
nnoremap <silent> + :bn<CR>
nnoremap <silent> _ :bp<CR>


" Run current file
command! Run :call utils#runCurrentFile()
nnoremap <silent> ,r :Run<CR>

" Reformat whole or selection from file
command! Format :call utils#formatFile()
nnoremap <silent> ,f :Format<CR>

"fancy tab key
inoremap <expr> <tab> utils#insertTabWrapper()
inoremap <s-tab> <C-n>

" 4.2 Unite
" -----------------------------------------------------

" Matcher settings
call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_hide_current_file'])
call unite#filters#sorter_default#use(['sorter_rank'])

" Use ag if available
if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C0'
    let g:unite_source_grep_recursive_opt=''

    " Set rec source command
    let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
endif

" Custom profile
call unite#custom#profile('default', 'context', {
            \   'prompt': '» ',
            \   'winheight': 15,
            \ })

" Add syntax highlighting
let g:unite_source_line_enable_highlight=1

" Dont override status line
let g:unite_force_overwrite_statusline=0

" Custom unite menus
let g:unite_source_menu_menus = {}

" Utils menu
let g:unite_source_menu_menus.utils = {
            \     'description' : 'Utility commands',
            \ }
let g:unite_source_menu_menus.utils.command_candidates = [
            \       ['Color picker', 'VCoolor'],
            \       ['Run XMPFilter', 'Annotate'],
            \       ['Format file', 'Format'],
            \       ['Run file', 'Run'],
            \       ['Generate Ctags', 'GenerateCT'],
            \       ['Generate JS Ctags', 'GenerateJSCT'],
            \       ['Show notes', 'Notes'],
            \     ]

" Git menu
let g:unite_source_menu_menus.git = {
            \     'description' : 'Git commands',
            \ }
let g:unite_source_menu_menus.git.command_candidates = [
            \       ['Stage hunk', 'GitGutterStageHunk'],
            \       ['Unstage hunk', 'GitGutterRevertHunk'],
            \       ['Stage', 'Gwrite'],
            \       ['Status', 'Gstatus'],
            \       ['Diff', 'Gvdiff'],
            \       ['Commit', 'Gcommit --verbose'],
            \       ['Revert', 'Gread'],
            \       ['Log', 'Glog'],
            \       ['Visual Log', 'Gitv'],
            \     ]

" Plug menu
let g:unite_source_menu_menus.plug = {
            \     'description' : 'Plugin management commands',
            \ }
let g:unite_source_menu_menus.plug.command_candidates = [
            \       ['Install plugins', 'PlugInstall'],
            \       ['Update plugins', 'PlugUpdate'],
            \       ['Clean plugins', 'PlugClean'],
            \       ['Upgrade vim-plug', 'PlugUpgrade'],
            \     ]

" My unite menu
let g:unite_source_menu_menus.unite = {
            \     'description' : 'My Unite sources',
            \ }
let g:unite_source_menu_menus.unite.command_candidates = [
            \       ['Unite MRUs', 'call utils#uniteMRUs()'],
            \       ['Unite buffers', 'call utils#uniteBuffers()'],
            \       ['Unite file browse', 'call utils#uniteFileBrowse()'],
            \       ['Unite file search', 'call utils#uniteFileRec()'],
            \       ['Unite grep', 'call utils#uniteGrep()'],
            \       ['Unite history', 'call utils#uniteHistory()'],
            \       ['Unite line search', 'call utils#uniteLineSearch()'],
            \       ['Unite menu', 'call utils#uniteCustomMenu()'],
            \       ['Unite registers', 'call utils#uniteRegisters()'],
            \       ['Unite snippets', 'call utils#uniteSnippets()'],
            \       ['Unite sources', 'call utils#uniteSources()'],
            \       ['Unite file tags (symbols)', 'call utils#uniteOutline()'],
            \       ['Unite tags', 'call utils#uniteTags()'],
            \       ['Unite windows', 'call utils#uniteWindows()'],
            \       ['Unite yank history', 'call utils#uniteYankHistory()'],
            \       ['Unite jump history', 'call utils#uniteJumps()'],
            \     ]

" -----------------------------------------------------
" 4.3 NERDTree
" -----------------------------------------------------
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=55
let g:NERDTreeAutoDeleteBuffer=1

" -----------------------------------------------------
" 4.4 Ultisnips settings
" -----------------------------------------------------
let g:UltiSnipsUsePythonVersion=3

" -----------------------------------------------------
" 4.5 Syntastic settings
" -----------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_log_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" -----------------------------------------------------
" 4.6 Deoplete settings
" -----------------------------------------------------
let g:deoplete#enable_at_startup = 1

" -----------------------------------------------------
" 4.9 Neomake settings
"------------------------------------------------------
let g:neomake_verbose=0
let g:neomake_warning_sign = {
            \ 'text': '>',
            \ 'texthl': 'WarningMsg',
            \ }
let g:neomake_error_sign = {
            \ 'text': '>',
            \ 'texthl': 'ErrorMsg',
            \ }

" 5.1 Unite and extensions
" -----------------------------------------------------

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Enable navigation with control-j and control-k in insert mode
    imap <silent> <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <silent> <buffer> <C-k> <Plug>(unite_select_previous_line)
    " Runs 'splits' action by <C-s> and <C-v>
    imap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    imap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    " Exit with escape
    nmap <silent> <buffer> <ESC> <Plug>(unite_exit)
    " Mark candidates
    vmap <silent> <buffer> m <Plug>(unite_toggle_mark_selected_candidates)
    nmap <silent> <buffer> m <Plug>(unite_toggle_mark_current_candidate)
endfunction

" Search files recursively ([o]pen file)
nnoremap <silent> <leader>o :call utils#uniteFileRec()<CR>
" Browse [f]iles in CWD
nnoremap <silent> <leader>f :call utils#uniteFileBrowse()<CR>
" [U]nite sources
nnoremap <silent> <leader>u :call utils#uniteSources()<CR>
" Search between open files - [b]uffers
nnoremap <silent> <leader>b :call utils#uniteBuffers()<CR>
" Search in current file ou[t]line (tags in current file)
nnoremap <silent> <leader>t :call utils#uniteOutline()<CR>
" Search for term - [g]rep
nnoremap <silent> <leader>g :call utils#uniteGrep()<CR>
" Search in edit [h]istory
nnoremap <silent> <leader>h :call utils#uniteHistory()<CR>
" Search in [l]ines on current buffer
nnoremap <silent> <leader>l :call utils#uniteLineSearch()<CR>
" Search in [y]ank history
nnoremap <silent> <leader>y :call utils#uniteYankHistory()<CR>
" Search in [r]egisters
nnoremap <silent> <leader>r :call utils#uniteRegisters()<CR>
" Search in opened [w]indow splits
nnoremap <silent> <leader>w :call utils#uniteWindows()<CR>
" Search in ultisnips [s]nippets
nnoremap <silent> <leader>s :call utils#uniteSnippets()<CR>
" Search in latest [j]ump positions
nnoremap <silent> <leader>j :call utils#uniteJumps()<CR>
" My custom unite [m]enu with commonly used commands not mapped to keys
nnoremap <silent> <leader>m :call utils#uniteCustomMenu()<CR>


" :W -  To write with root prives
function! W() abort
:execute ':silent w !sudo tee % > /dev/null' | :edit!
endfunction
