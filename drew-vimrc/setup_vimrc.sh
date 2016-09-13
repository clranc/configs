#!/bin/bash

# Move to directory of script
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Backup old vimrc files
if [ -f ~/.vimrc ]; then
	mv ~/.vimrc ~/.vimrc.old
fi;
if [ -f ~/.vimrc_bundles ]; then
	mv ~/.vimrc_bundles ~/.vimrc_bundles.old
fi;
if [ -f ~/.vimrc_vundle ]; then
	mv ~/.vimrc_vundle ~/.vimrc_vundle.old
fi;

# Create symlinks between local vimrc files and the actual vimrc files
ln -sf "$PWD/.vimrc" ~/
ln -sf "$PWD/.vimrc_vundle" ~/
ln -sf "$PWD/.vimrc_bundles" ~/

# Install Vundle (https://github.com/gmarik/vundle)
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Clean/install bundles
vim -u .vimrc_setup

