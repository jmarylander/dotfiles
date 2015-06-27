filetype off

set rtp+=$home/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'https://github.com/leafgarland/typescript-vim.git'
Plugin 'bling/vim-airline'

call vundle#end()          
filetype plugin indent off


"Config for plugins

source airline.vim

