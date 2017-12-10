#!/bin/bash

mkdir -p ~/.config
ln -s $PWD/nvim ~/.config/nvim
ln -s ~/.config/nvim ~/.vim
ln -s ~/.config/nvim/init.vim ~/.vimrc
