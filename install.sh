#!/usr/bin/env bash

mv ~/.vimrc ~/.vimrc.old
cp ./.vimrc ~/.vimrc

git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2> /dev/null

vim +PluginInstall +qall

echo "Installation Complete!"
