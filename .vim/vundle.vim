filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'

call vundle#end()          
filetype plugin indent off


"Config for plugins

source ~/.vim/airline.vim
