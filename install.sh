#!/bin/bash

set -e

dir=~/dotfiles
olddir=~/dotfiles_old

basefiles=".bin .config/nvim .config/base16-shell .fonts .gitconfig .gitignore .tmux.conf .zshrc"
guifiles=".compton.conf .config/base16-shell .config/gtk-2.0 .config/gtk-3.0 .conkyrc .config/xfce4 .fehbg .gtkrc-2.0 .i3 .lock.png .wallpaper.jpg .Xauthority .Xresources"

ask() {
    # http://djm.me/ask
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
        read -p "$1 [$prompt] " REPLY </dev/tty

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

if ask "Install missing software?" Y; then
    if ask "Are you running Debian and want to install missing packages?" Y; then
        sudo apt-key add ./packages/repo.keys
        sudo cp -R ./packages/sources.list* /etc/apt/
        sudo apt-get update
        sudo apt-get install dselect
        sudo dselect update
        sudo dpkg --set-selections < ./package-selections
        sudo apt-get dselect-upgrade -y
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    fi

    if ask "Install neovim?" Y; then
        distro=`cat /etc/*-release`

        if [[ $distro == *"debian"* ]]; then
            sudo apt-get install git libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
            git clone https://github.com/neovim/neovim
            cd neovim
            make && sudo make install
            sudo pip3 install neovim
            cd ..
        fi
        if [[ $distro == *"ubuntu"* ]]; then
            sudo apt-get install software-properties-common
            sudo apt-get install python-dev python-pip python3-dev python3-pip
            sudo add-apt-repository ppa:neovim-ppa/unstable
            sudo apt-get update
            sudo apt-get install neovim

            sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
            sudo update-alternatives --config vi
            sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
            sudo update-alternatives --config vim
            sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
            sudo update-alternatives --config editor
        fi
        if [[ $distro == *"centos"* ]]; then
            sudo yum -y install git autoconf automake cmake gcc gcc-c++ libtool make pkgconfig unzip
            git clone https://github.com/neovim/neovim
            cd neovim
            make && sudo make install
            cd ..
        fi
        if [[ $distro == *"arch"* ]]; then
            sudo pacman -Syu neovim
            sudo pacman -S python2-neovim python-neovim
        fi

    fi

    if ask "Install i3-gaps?" Y; then
        #i3-gaps
        git clone https://www.github.com/Airblader/i3 i3-gaps
        cd i3-gaps
        git checkout gaps && git pull
        make
        sudo make install
    fi

    if ask "Install material design lockscreen?" Y; then
        #lightdm-webkit-greeter
        wget https://launchpad.net/lightdm-webkit-greeter/trunk/1.0/+download/lightdm-webkit-greeter-1.0.tar.gz
        tar xfv lightdm-webkit-greeter-1.0.tar.gz
        rm lightdm-webkit-greeter-1.0.tar.gz
        cd lightdm-webkit-greeter-1.0
        ./configure
        make
        sudo make install

        cd /usr/share/lightdm-webkit/themes
        sudo git clone https://github.com/artur9010/lightdm-webkit-material.git
        sudo sed -i 's/manokwari-theme-greeter/lightdm-webkit-material/g' /etc/lightdm/lightdm-webkit-greeter.conf
        sudo sed -i 's/#*greeter-session*/greeter-session=lightdm-webkit-greeter #/g' /etc/lightdm/lightdm.conf
    fi

    if ask "Install moka icon them?" Y; then
        #moka-icon-theme
        git clone https://github.com/moka-project/moka-icon-theme.git
        cd moka-icon-theme
        bash autogen.sh
        make
        sudo make install
    fi

    if ask "Install oh-my-zsh" Y; then
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
fi

if ask "Install all symlinks?" Y; then
    # create dotfiles_old in homedir
    echo "Creating $olddir for backup of any existing dotfiles in ~"
    mkdir -p $olddir
    echo "...done"

    # change to the dotfiles directory
    echo "Changing to the $dir directory"
    cd $dir
    echo "...done"

    # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
    for file in $basefiles; do
        echo "Moving any existing dotfiles from ~ to $olddir"
        if [ -a ~/$file ]; then
            mv ~/$file $olddir
        fi
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/$file
    done
    echo "symlinking gui files now"
    for file in $guifiles; do
        echo "Moving any existing dotfiles from ~ to $olddir"
        if [ -a ~/$file ]; then
            mv ~/$file $olddir
        fi
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/$file
    done
else
    if ask "Install basefile symlinks?" Y; then

        # create dotfiles_old in homedir
        echo "Creating $olddir for backup of any existing dotfiles in ~"
        mkdir -p $olddir
        echo "...done"

        # change to the dotfiles directory
        echo "Changing to the $dir directory"
        cd $dir
        echo "...done"

        # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
        for file in $basefiles; do
            echo "Creating symlink to $file in home directory."
            ln -s $dir/$file ~/.$file
        done
    fi
fi

echo "To have backlight cli install https://github.com/haikarainen/light"
echo "To have i3 dialogs install yad. see sourceforge"
echo "Done!"
