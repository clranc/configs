#!/bin/bash

# Move to directory of script
cd "$( dirname "${BASH_SOURCE[0]}" )"

files=".bashrc .bashrc.sh .profile .git-prompt.sh"
backupfiles="$files .bash_profile"

for fl in $backupfiles; do
	if [ -f ~/$fl ]; then
		mv ~/$fl ~/$fl.old
	fi;
done

# Create symlinks between local vimrc files and the actual vimrc files
for fl in $files; do
	ln -sf "$PWD/$fl" ~/
done


