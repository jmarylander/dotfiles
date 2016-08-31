export ZSH=/home/joey/.oh-my-zsh

ZSH_THEME="agnoster"
COMPLETION_WAITING_DOTS="true"
# ZSH_TMUX_AUTOSTART="true"
# ZSH_TMUX_AUTOQUIT="true"

plugins=(tmux jump)

export PATH="/bin/:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
source $ZSH/oh-my-zsh.sh

alias vimrc="vim ~/.vimrc"

if type nvim > /dev/null 2>&1; then
  export EDITOR="nvim"
  alias vim='nvim'
  alias vimrc="nvim ~/.config/nvim/init.vim"
fi

alias sudo="nocorrect sudo "

alias l="ls -lFh"
alias la="ls -lAFh"
alias lr="ls -tRFh"
alias lt="ls -ltFh"
alias ll="ls -l"
alias ldot="ls -ld .*"
alias lS="ls -1FSsh"
alias lart="ls -1Fcart"
alias lrt="ls -1Fcrt"

alias j="jump"

alias zshrc="nvim ~/.zshrc"
alias i3conf="nvim ~/.i3/config"
alias tmuxconf="nvim ~/.tmux.conf"

alias install="sudo apt install"
alias remove="sudo apt remove"
alias update="sudo apt update"
alias search="sudo apt search"

alias quit="exit"
alias :q="exit"

alias univpn="sudo ~/.ssh/unix/univpn"

alias ta='tmux attach -t main || tmux new -s main'
alias td='tmux detach'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -o'

xfer() {
    # write to output to tmpfile because of progress bar
    tmpfile=$( mktemp -t transferXXX )
    curl --progress-bar --upload-file $1 https://transfer.sh/$(basename $1) >> $tmpfile;
    cat $tmpfile;
    rm -f $tmpfile;
}
alias transfer=xfer

unixssh(){
    (ps -ef | grep openvpn | grep -v grep | grep -q ovpn)
    vpn=$?
    pw="Tree5House\!\r"
    if [[ $vpn -ne 0 ]] ; then
        sudo ~/.ssh/unix/univpn
        sleep 5s
    fi
    cmd="spawn ssh un$1;\
        expect 'root@100.64.17.$1\'s password: ';\
        send $pw;\
        interact;"
    /usr/bin/expect -c $cmd
}
alias ussh=unixssh

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

alias extract=ex

np() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9-_%^&*(){}?><,./;:' | fold -w $1 | head -1
}
alias newPassword=np
alias vimi='vim $(fzf)'

# Git aliases
alias gc="git commit -m "$1""
alias gaa="git add -A ."
alias gp="git push $1 $2"
alias glo="git log --oneline"
alias gsa="git status"

BASE16_SHELL="$HOME/.config/base16-shell/base16-gooey.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export NVM_DIR="/home/joey/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
