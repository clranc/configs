# .bashrc
# Source global definitions
if [ -f ~/.bashrc.sh ]; then
	. ~/.bashrc.sh
fi

if [ -f /etc/profile.d/nix.sh ]; then
	. /etc/profile.d/nix.sh
fi

GRADLE=/usr/local/gradle-source-build/bin

PATH=/tools/Xilinx/Vivado/2018.3/bin/:$HOME/bin:$HOME/.local/bin:/usr/local/texlive/2019/bin/x86_64-linux:/usr/bin:/usr/local/bin:$GRADLE:$PATH

# Python Virtualenv path stuff
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel
#source /usr/local/bin/virtualenvwrapper.sh


# User specific aliases and functions

alias TERM="xterm-256color"
alias tmux="tmux -2"
alias view="vim -R"
alias python="python3"
alias pydoc="pydoc3"
alias objdump="objdump -Mintel"

alias manall="apropos . | less"
alias manall2="man -k . | less"

#alias ls="ls --color"

#infinite history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

export HISTFILE=~/.bash_eternal_history



PROMPT_COMMAND="$PROMPT_COMMAND; history -a"

