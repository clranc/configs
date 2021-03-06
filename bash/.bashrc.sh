# /etc/bash/bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

# Save each command to the history file as it's executed.  #517342
# This does mean sessions get interleaved when reading later on, but this
# way the history is always up to date.  History is not synced across live
# sessions though; that is what `history -n` does.
# Disabled by default due to concerns related to system recovery when $HOME
# is under duress, or lives somewhere flaky (like NFS).  Constantly syncing
# the history will halt the shell prompt until it's finished.
#PROMPT_COMMAND='history -a'

# Change the window title of X terminals
case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|interix)
		PS1='\[\033]0;\u@\w\007\]'
		;;
	screen*)
		PS1='\[\033k\u@\h:\w\033\\\]'
		;;
	*)
		unset PS1
		;;
esac

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.
# We run dircolors directly due to its changes in file syntax and
# terminal name patching.
use_color=false
if type -P dircolors >/dev/null ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	LS_COLORS=
	if [[ -f ~/.dir_colors ]] ; then
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	else
		eval "$(dircolors -b)"
	fi
	# Note: We always evaluate the LS_COLORS setting even when it's the
	# default.	If it isn't set, then `ls` will only colorize by default
	# based on file attributes and ignore extensions (even the compiled
	# in defaults of dircolors). #583814
	if [[ -n ${LS_COLORS:+set} ]] ; then
		use_color=true
	else
		# Delete it if it's empty as it's useless in that case.
		unset LS_COLORS
	fi
else
	# Some systems (e.g. BSD & embedded) don't typically come with
	# dircolors so we need to hardcode some terminals in here.
	case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|screen|cons25|*color) use_color=true;;
	esac
fi

. ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=true



if ${use_color} ; then
	if [[ ${EUID} == 0 ]] ; then  #Check if root user
	PS1+='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
	else
	PS1+='\[\033[01;32m\]\u@\h\[\033[00m\]:$(__git_ps1 "%s")\[\033[00m\]: \[\033[01;34m\]\W \$\[\033[00m\] '
	fi

	alias less='less -R'
	alias ls='ls --color=always'
	alias grep='grep --colour=always'
	alias egrep='egrep --colour=always'
	alias fgrep='fgrep --colour=always'
else
	# show root@ when we don't have colors
	PS1+='\u@\h \w \$ '
fi

for sh in /etc/bash/bashrc.d/* ; do
	[[ -r ${sh} ]] && source "${sh}"
done

color_str()
{
	echo -en "\033\[38;5;${1}m\]"
}

prompt_pwd() {
	case "$PWD" in
		"$HOME")
			echo "~"
			;;
		*)
			printf "%s" $(echo $PWD|sed -e "s|^$HOME|~|" -e 's-/\(\.\{0,1\}[^/]\)\([^/]*\)-/\1-g')
			echo "$PWD" | sed -n -e 's-.*/\.\{0,1\}.\([^/]*\)-\1-p'
			;;
	esac
}

prompt_func()
{
	local ret="$(echo $?)"
	local red="\[\033[38;5;196m\]"
	local magenta="\[\033[38;5;201m\]"
	local green="\[\033[38;5;10m\]"
	local blue="\[\033[38;5;33m\]"
	local yellow="\[\033[38;5;11m\]"
	local end="\[\033[00m\]"

	local face=""
	local hface="${magenta}^_^${end}"
	local cface="${red}-_:/_-${ret}${end}"

	face="$([[ $ret == "0" ]] && echo -en "$hface" || echo -en "$cface")"

	local promptface="\n${blue}└[$face${blue}]${end}"

    local start="${blue}┌[${green}\\u@\h${blue}]-[${magenta}$(prompt_pwd)${blue}]${promptface}"

	local gitstr="${blue}-[%s${blue}]${end}"

	local end="${blue}>${end}"

	__git_ps1 $start $end $gitstr
}

#PROMPT_COMMAND='__git_ps1 "┌[\[\033[01;32m\]\\u@\h" " \[\033[01;34m\]\W \n└[]>\\\$ \[\033[00m\]" '

# Try to keep environment pollution down, EPA loves us.
unset use_color sh
