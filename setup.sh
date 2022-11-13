#!/bin/sh

# create directories
echo "creating directories..."
mkdir .config/nvim
mkdir .config/kitty

# symlink files
echo "symlinking files..."
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.zsh ~/.zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -s ~/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

echo "init zsh plugins maintained as git submodules..."
cd .zsh && git submodule update --init --recursive
# to update
# git submodule update --remote --merge

echo "done"
