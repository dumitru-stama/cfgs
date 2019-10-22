#!/bin/bash
sudo apt update
sudo apt install git tig zsh tmux neovim mc htop build-essential python3 python3-pip yasm p7zip p7zip-full gparted -y
sudo apt autoremove -y

echo Setting up MC
mkdir ~/.config/mc
cp -rf mc ~/.config

echo Setting up NeoVIM
mkdir ~/.config/nvim
cp -rf nvim ~/.config

echo Set NeoVIM as selected editor
cp -f selected_editor/.selected_editor ~

echo Setting up ZSH
cp -f zsh/.zshrc ~

echo Setting up Tmux
cp -f tmux/.tmux.conf ~

echo Setting current user shell to ZSH
ZSH=`which zsh`
sudo usermod --shell $ZSH $USER

echo ----------------------------------------
read -p "Do you want to restart ?" -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo /sbin/shutdown -r now
fi

