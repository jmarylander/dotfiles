alias install="sudo apt-get install"
alias search="sudo apt-cache search"
alias quit='exit'
function fish_prompt
  ~/.powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

set fish_greeting ""
function sudo
  if test "$argv" = !!
    eval command sudo $history[1]
  else
    command sudo $argv
  end
end


function fuck
  eval (thefuck $history[1])
end
