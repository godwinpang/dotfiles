#!/usr/bin/env bash

mv ~/.vimrc ~/.vimrc.old
cp ./.vimrc ~/.vimrc

vim +PlugInstall +qall

echo "Installation Complete!"
