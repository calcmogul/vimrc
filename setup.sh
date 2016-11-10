#!/bin/bash
# $1 is absolute path to vimrc Git repository

if [ $# -ne 1 ]; then
  echo Usage: ./setup.sh
  exit 1
fi

mkdir -p ~/.config
ln -s $PWD/nvim ~/.config/nvim
ln -s ~/.config/nvim ~/.vim
ln -s ~/.config/nvim/init.vim ~/.vimrc
