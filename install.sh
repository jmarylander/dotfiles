#!/bin/bash

set -e

pushd `dirname $0` > /dev/null
dir=`pwd`
popd > /dev/null
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

if ! ask "Are you currently in the same directory as the install script?" Y; then
    echo "Please change directories to the dotfiles directory"
    exit 1
fi

if ask "Install missing packages?" Y; then
    sudo apt-get install dselect
    sudo dpkg --set-selections < ./package-selections
    sudo apt-get dselect-upgrade

    #i3-gaps
    cd ${HOME}
    mkdir src
    cd src
    git clone https://www.github.com/Airblader/i3 i3-gaps
    cd i3-gaps
    git checkout gaps && git pull
    make
    sudo make install
    
    #lightdm-webkit-greeter
    wget https://launchpad.net/lightdm-webkit-greeter/trunk/1.0/+download/lightdm-webkit-greeter-1.0.tar.gz
    tar xfv lightdm-webkit-greeter-1.0.tar.gz
    rm lightdm-webkit-greeter-1.0.tar.gz
    cd light-webkit-greeter
    ./configure
    make
    sudo make install
    
    cd /usr/share/lightdm-webkit/themes
    sudo git clone https://github.com/artur9010/lightdm-webkit-material.git
    sudo sed -i 's/manokwari-theme-greeter/lightdm-webkit-material/g' /etc/lightdm/lightdm-webkit-greeter.conf
    sudo sed -i 's/#greeter-session=lightdm-gtk-greeter/greeter-session=lightdm-webkit-greeter/g' /etc/ligtdm/lightdm.conf

    #moka-icon-theme
    cd ${HOME}/src
    git clone https://github.com/moka-project/moka-icon-theme.git
    cd moka-icon-theme
    bash autogen.sh
    make
    sudo make install

fi


#TODO refactor symlinks install
if ask "Install symlinks?" Y; then
    for f in $dir/.*; do
        if [[ "$f" != *"." ]]; then 
            if [[ "$f" != *".." ]]; then
                if [[ "$f" != *"package-selections"* ]]; then
                    if [[ "$f" != *"install.sh"* ]]; then
                        if [ -d $f ]; then
                            if [[ "$f" == *".config"* ]]; then
                                for c in .config/*; do
                                    ln -sfn $dir/$c ${HOME}/$c
                                done
                            else
                                ln -sfn $f ${HOME}/$(basename $f)
                            fi

                        else
                            ln -sf $f ${HOME}/$(basename $f)
                        fi
                    fi
                fi
            fi
        fi
    done
fi

