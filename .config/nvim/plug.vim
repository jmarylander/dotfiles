call plug#begin('~/.config/nvim/plugged')

Plug 'chriskempson/base16-vim'

Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Asynchronous maker and linter (needs linters to work)
Plug 'benekastah/neomake', { 'on': ['Neomake'] }
" Automatically closing stuff
Plug 'cohama/lexima.vim'
" Snippets support
Plug 'SirVer/ultisnips'
" Commenting support (gc)
Plug 'tpope/vim-commentary'
" Multi-language testing support
Plug 'janko-m/vim-test', { 'on': ['TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit'] }
" CamelCase and snake_case motions
Plug 'bkad/CamelCaseMotion' 
" Python syntax
Plug 'mitsuhiko/vim-python-combined'
" Elm
Plug 'lambdatoast/elm.vim'
" Markdown syntax and helpers
Plug 'plasticboy/vim-markdown'
" Tmux syntax
Plug 'tejr/vim-tmux'
" Git syntax
Plug 'tpope/vim-git'

" Unite files, buffers, command sources | Async source depends on vimproc
Plug 'Shougo/unite.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Outline source
Plug 'Shougo/unite-outline'
" History/yank source
Plug 'Shougo/neoyank.vim'
" MRU source
Plug 'Shougo/neomru.vim'
" Tag source
Plug 'tsukkee/unite-tag'
" Colorscheme source
Plug 'ujihisa/unite-colorscheme'

" Lightline (simple status line)
Plug 'itchyny/lightline.vim'
" Buffers tabline
Plug 'ap/vim-buftabline'

" Fugitive
Plug 'tpope/vim-fugitive'
" Color picker
Plug 'KabbAmine/vCoolor.vim', { 'on': 'VCoolor' }
" Neovim terminal improving
Plug 'kassio/neoterm', { 'on': 'T' }
" Unix commands integration
Plug 'tpope/vim-eunuch'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'
" Additional text objects
Plug 'wellle/targets.vim'
" Surround (cs"')
Plug 'tpope/vim-surround'
" Easy alignment
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }
" Safely editing in isolation
Plug 'ferranpm/vim-isolate', { 'on':  ['Isolate', 'UnIsolate'] }

" Easily expand selected region
Plug 'terryma/vim-expand-region'
" Search for highlighted work with *
Plug 'thinca/vim-visualstar'
" Intelligent buffer closing
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" Iabbrev auto-correction library
Plug 'chip/vim-fat-finger'
" Hacker typing
Plug 'natw/keyboard_cat.vim', { 'on':  'PlayMeOff' }
" Man reading in vim
Plug 'jez/vim-superman'
" Matchit enhances motions
Plug 'edsono/vim-matchit'
" More . repeat functionality
Plug 'tpope/vim-repeat'
" Delete all but current buffer
Plug 'vim-scripts/BufOnly.vim'

"autocomplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Global Syntax highlighting
"Plug 'scrooloose/syntastic'

call plug#end()
