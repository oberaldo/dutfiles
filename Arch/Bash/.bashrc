#################################################
#  ____    ____   _____ __ __  ____      __     #
# |    \  /    T / ___/|  T  T|    \    /  ]    # 
# |  o  )Y  o  |(   \_ |  l  ||  D  )  /  /     #
# |     T|     | \__  T|  _  ||    /  /  /      #
# |  O  ||  _  | /  \ ||  |  ||    \ /   \_     #
# |     ||  |  | \    ||  |  ||  .  Y\     |    # 
# l_____jl__j__j  \___jl__j__jl__j\_j \____j    #
#################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Pkgfile includes a "command not found" hook for Bash and Zsh that will automatically search the official repositories, when entering an unrecognized command:
#  source /usr/share/doc/pkgfile/command-not-found.bash
  

# Powerline
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
   POWERLINE_BASH_CONTINUATION=1
   POWERLINE_BASH_SELECT=1
   . /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh
   
fi


# Git bash prompt
source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWDIRTYSTATE=true


# Syntax coloring# wget https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS -O ~/.dircolors
eval $(dircolors -b $HOME/.dircolors)
alias ls="ls -F -h --color=auto"


# Don't put duplicate lines or lines starting with space in the history.
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Date and Timestamp in history
#Restrict bash history to unique commands, no duplicates
HISTCONTROL=ignoreboth,erasedups
HISTSIZE=1000
HISTFILESIZE=2000 
HISTTIMEFORMAT='%F %T  '
HISTFILE=~/.bash_history

# Context search through history (like zsj)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind 'set completion-ignore-case on'


# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
   fi
fi 

# Make auto completion more zsh-like
bind 'set show-all-if-ambiguous on'

#Ssh autocomplete
#complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp

# Set the EDITOR variable
export EDITOR='vim'
export VISUAL='vim'

# Append to the history file, don't overwrite it
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# Set prompt to vi mode.
# Report status of terminated background jobs immediately.
# Auto cd 
# Expanded globbing (i.e. allow 'ls -d ^*.jpg' to show  non-jpg files)
# Mispelled directory names
# Require '>|' instead of '>' to overwrite a file
# Correct spelling on directory names during  globbing
set -o noclobber
set -o vi               
set -o notify 
shopt -s checkwinsize
shopt -s cdspell 
shopt -s autocd
shopt -s histappend
shopt -s extglob
shopt -s cdspell         
shopt -s dirspell 

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
    fi

# Bash Functions File
if [ -f ~/.bash_functions ]; then
. ~/.bash_functions
fi

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" 

# Autojump 
source /etc/profile.d/autojump.bash  
export AUTOJUMP_IGNORE_CASE=1
export AUTOJUMP_AUTOCOMPLETE_CMDS='cp vim'

# Coloring the output of various programs
GRC=`which grc`
if [ "$TERM" != dumb ] && [ -n "$GRC" ]
then
    alias colourify="$GRC -es --colour=auto"
    alias cfg='colourify ./configure'
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias make='colourify make' 
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
    alias head='colourify head'
    alias tail='colourify tail'
    alias dig='colourify dig'
    alias mount='colourify mount'
    alias ps='colourify ps'
    alias mtr='colourify mtr'
    alias df='colourify df'

fi


bind -x '"\C-p":"ifconfig"'