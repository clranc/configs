set fish_user_paths $fish_user_paths $HOME/bin $HOME/.gem/ruby/2.3.0/bin $HOME/.local/bin /usr/sbin/ /home/cranc/Programs/esp8266/compiler/esp-open-sdk/xtensa-lx106-elf/bin/ /usr/local/texlive/2017/bin/x86_64-linux/ /opt/gcc-arm-none-eabi-7-2017-q4-major/bin/ /opt/bin/

set fish_greeting ""

alias zandronum "wine ~/Documents/DoomStuff/zandronum/zandronum.exe &"
alias doomseeker "wine ~/Documents/DoomStuff/zandronum/Doomseeker/doomseeker.exe &"
alias zdl "wine ~/Documents/DoomStuff/ZDL-3.2.2.2-stable/ZDL.exe &"
alias TERM "xterm-256-color"
alias tmux "tmux -2"
alias view "vim -R"
alias minecraft "java -jar /home/cranc/Documents/Minecraft/Minecraft.jar"
alias gscreen "gnome-screenshot -ai"
alias remotedesktop "vinagre"

alias vsplit "tmux split -h"
alias hsplit "tmux split -v"

set -g __fish_git_prompt_char_stateseparator "|"
set -g __fish_git_prompt_showcleanstate 'yes'
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showstashstate 'yes'
set -g __fish_git_prompt_showuntrackedfiles 'yes'

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_stashstate -o red
set -g __fish_git_prompt_color_untrackedfiles yellow
set -g __fish_git_prompt_color_cleanstate -o green
#set -g __fish_git_prompt_color_stateseparator -o green

