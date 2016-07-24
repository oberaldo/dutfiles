#   _________  _   _ ____   ____
#  |__  / ___|| | | |  _ \ / ___|
#    / /\___ \| |_| | |_) | |    
# _ / /_ ___) |  _  |  _ <| |___
#(_)____|____/|_| |_|_| \_\\____|
#
#############################################################################################################
#.zshrc - Initialization file for Z shell                                                                   #
#Created by: Thiago Silva                                                                                   #
#Email :thiagors1983@gmail.com                                                                              #
#Based on configuration used for Sandro Marcel  (https://www.vivaolinux.com.br/etc/.zshrc-SMarcell)         #
#Linux is power                                                                                             #
#Before using, look all the confs with attention, and solve all dependencies to work properly               #
#The aliases used in this configuration are exclusive from Arch Linux and derivates.                        #
#############################################################################################################
#Rainbow
#export WORKON_HOME=~/.rainbow
#source /usr/bin/virtualenvwrapper.sh

# Variables:
  export BROWSER="firefox"
  export EDITOR="vim"
 
# Zsh-syntax-highlighting
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#Syntax-highlighting  similar to shell Fish. Its necessary install the package zsh-syntax-highlighting
 
# pkgfile includes a "command not found" hook for Bash and Zsh that will automatically search the official repositories, when entering an unrecognized command:
#  source /usr/share/doc/pkgfile/command-not-found.zsh
 
# Historic
   export HISTFILE=${HOME}/.zsh_history
   export HISTSIZE=5000
   export SAVEHIST=$HISTSIZE
 
# Historic options:
 setopt EXTENDED_HISTORY
 setopt HIST_VERIFY
 setopt HIST_REDUCE_BLANKS
 setopt HIST_IGNORE_ALL_DUPS
 
#View the last accessed directories.The command is "dirs -v"
 
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}
 
DIRSTACKSIZE=20
 
setopt autopushd pushdsilent pushdtohome

setopt prompt_subst

## Remove duplicate entries
setopt pushdignoredups

 
##Autocomplete for aliases
setopt completealiases
 
##Search history
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward
 
## This reverts the +/- operators.
setopt pushdminus
 
# Loading some useful modules:
    zmodload -i zsh/complete
    zmodload -i zsh/mapfile
    zmodload -i zsh/mathfunc
    zmodload -i zsh/complist
    zmodload -i zsh/curses
    zmodload -i zsh/datetime
    zmodload -i zsh/terminfo
 
# Loading module zmv
    autoload -U zmv
 
 # Enabling self-correction:
    setopt correct
    setopt correct_all
    export sprompt="$(print '%{\e[37m%}zsh: Corrigir para %S%r%s ? (n|y|e): %{\e[0m%}')"
 
 # Allows the use of wildcards: *?_-.[]~=/&;!#$%^(){}<>
    setopt extended_glob
 
 # Allowing self cd (There is no need to use the command cd):
    setopt auto_cd
    setopt cdable_vars
    setopt auto_pushd
    setopt pushd_ignore_dups
    setopt pushd_silent
 
 # Auto-complete with <TAB>
    setopt auto_list
    setopt auto_menu
    setopt case_glob
    setopt list_types
    setopt glob_complete
    setopt menu_complete
    setopt complete_in_word
    setopt complete_aliases
    autoload -Uz compinit promptinit
    compinit
    promptinit
    autoload -U colors 
    colors
 
 # Bindkeys
   bindkey -v
   bindkey '^R' history-incremental-search-backward
   #Cleaning terminal screen with key <ESC>:
   bindkey '^[' clear-screen
   #bindkey '^P'  
   # Kill input from the current point to the end of line with Ctrl-k
   bindkey '^k' kill-line

  typeset -A key
 
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
 
# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
 
# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}
 
if [ -n "${DISPLAY:-}" ]; then
   zle -N zle-line-init
   zle -N zle-line-finish
fi
 
 # Enabling verbose mode:
   zstyle ':completion:*' verbose 'yes'
   zstyle ':completion:*' show-completer
 
# Persistent repetition:
   zstyle ':completion:*' rehash true
 
 # Colored stripe complementation:
   zstyle ':completion:*:default' list-colors ${(s.:.)ZLS_COLORS}
 
 # Visual selection menu:
   zstyle ':completion:*' menu select=3 _complete _i-patterns ignored_approximate
   zstyle ':completion:*' select-prompt '%S zsh: Seleção atual = %p %s'
 
 # Auto description of possible additions:
   zstyle ':completion:*:options' description 'yes'
   zstyle ':completion:*:options' auto-description '%d'
 
 # Format of self-completion messages:
   zstyle ':completion:*:corrections' format '%Bzsh: %d (erros: %e)%b'
   zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
   zstyle ':completion:*:warnings' format '%Bzsh: Inválido como: %d%b'
 
 # Listing self-complementation groups:
   zstyle ':completion:*:matches' groups 'yes'
   zstyle ':completion:*' list-grouped
   zstyle ':completion:*' group-name ''
   zstyle ':completion:*:*:-command-:*' group-order commands builtins
 
 # Expand as much as possible:
   zstyle ':completion:incremental:*' completer _complete _correct
   zstyle ':completion:*' completer _complete _correct _match _approximate
   zstyle ':completion:*:expand:*' tag-order all-expansions
 
 # Number of errors to accept for autocompletion:
   zstyle ':completion:*:approximate:*' max-errors 2 numeric
 
 # Use '/d/s <TAB>' to expand to '/dir/subdir':
   zstyle ':completion:*' expand 'yes'
   zstyle ':completion:*' squeeze-slashes 'yes'
 
 # Preserve prefix/suffix for autocompletion:
  zstyle ':completion:*' expand prefix suffix
  zstyle ':completion:*' completer _complete _prefix _match _approximate
  zstyle ':completion:*' preserve-prefix '//[^ /]##/'
  zstyle ':completion:*:match:*' original only
  zstyle ':completion:*approximate :*' max-errors 1 numeric
 
 # Option auto-cd should ignore the current directory:
   zstyle ':completion:*:cd:*' ignore-parents parent pwd
 
 # Avoid duplicate entries for the commands below:
   zstyle ':completion:*:rm:*' ignore-line 'yes'
   zstyle ':completion:*:cp:*' ignore-line 'yes'
   zstyle ':completion:*:mv:*' ignore-line 'yes'
 
 # Case-sensitive self-complementation:
   zstyle ':completion:*:complete:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
 
 # Self-complementary from Wildcards:
   zstyle ':completion:*:complete-extended:*' matcher 'r:|[.,_-]=* r:|=*'
 
 # Ignore auto-completion of internal functions of zsh:
   zstyle ':completion:*:functions' ignored-patterns '_*'
 
# Autocomplete for the command 'kill':
   zstyle ':completion:*:processes' command 'ps x -o pid,command'
   zstyle ':completion:*:kill:*' menu yes select
   zstyle ':completion:*:kill:*' force-list always
   zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
 
# Command help in the Zsh
  autoload -U run-help
  autoload run-help-git
  autoload run-help-svn
  autoload run-help-svk
  
 
# Syntax coloring# wget https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS -O ~/.dircolors
  eval $(dircolors -b $HOME/.dircolors)
  alias ls="ls -F -h --color=auto"
 
#####################################################################################################################
## functions
#####################################################################################################################
#
# myip - Find the external IP when connected to internet
function meuip ()
{
 
lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{
print $4}' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g'
 }
 
# Mass rename images
function renomear ()
{ctd=1 ; for i in * ; do zeros=$(printf "%03d\n" ${ctd}) ; mv $i wallpaper_${zeros}.jpg ; ((ctd++)) ; done
}
 
# Color man pages: #pacman -S most
 if [ -e $(which most) ]
 then
    export PAGER='most -s'
    export LESSHISTFILE='-'
 else
    export PAGER=less
 fi
 
# Coloring the output of various programs.#pacman -S grc  
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
 
# Calculate real memory used (desconsider the cache)
function  mem(){
 echo "`free|grep Mem|awk '{printf(\"%.0f\",($3-($6+$7))/1000)}'` MiB";
}
 
# List erros in logs from the last system boot
function logerr(){ journalctl -p 3 -xb}
 
#Show only user processes.
function  psuser() {
 ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ;
}
 
function imgur-upl() { # Image upload to imgur site
        curl -s -F image=@"$1" -F "key=1913b4ac473c692372d108209958fd15" \
        http://api.imgur.com/2/upload.xml | grep -Eo "<original>(.)*</original>" \
        | grep -Eo "http://i.imgur.com/[^<]*"
}
 
#hastebin
function haste() { # File upload to hastebin, with syntax highlight support.
a=$(cat); curl -X POST -s -d "$a" http://hastebin.com/documents | awk -F '"' '{print "http://hastebin.com/"$4}';
}
 
function start() { sudo systemctl start $@ ; }
function stop()  { sudo systemctl stop $@ ;  }
function restart() { sudo systemctl restart $@ ; }
function status()  { sudo systemctl status $@ ; }
#function ativar()  { sudo systemctl enable $@ ; }
function disable() { sudo systemctl disable $@ ; }
 
ac() { # compress a file or folder
    case "$1" in
       tar.bz2|.tar.bz2) tar cvjf "${2%%/}.tar.bz2" "${2%%/}/"  ;;
       tbz2|.tbz2)       tar cvjf "${2%%/}.tbz2" "${2%%/}/"     ;;
       tbz|.tbz)         tar cvjf "${2%%/}.tbz" "${2%%/}/"      ;;      
       tar.xz)         tar cvJf "${2%%/}.tar.xz" "${2%%/}/"      ;;      
       tar.gz|.tar.gz)   tar cvzf "${2%%/}.tar.gz" "${2%%/}/"   ;;
       tgz|.tgz)         tar cvjf "${2%%/}.tgz" "${2%%/}/"      ;;
       tar|.tar)         tar cvf  "${2%%/}.tar" "${2%%/}/"        ;;
       rar|.rar)         rar a "${2}.rar" "$2"            ;;
       zip|.zip)         zip -9 "${2}.zip" "$2"            ;;
       7z|.7z)         7z a "${2}.7z" "$2"            ;;
       lzo|.lzo)         lzop -v "$2"                ;;  
       gz|.gz)         gzip -v "$2"                ;;
       bz2|.bz2)         bzip2 -v "$2"                ;;
       xz|.xz)         xz -v "$2"                    ;;
       lzma|.lzma)         lzma -v "$2"                ;;  
           *)           echo "ac(): compress a file or directory."
            echo "Usage:   ac <archive type> <filename>"
            echo "Example: ac tar.bz2 PKGBUILD"
            echo "Please specify archive type and source."
            echo "Valid archive types are:"
            echo "tar.bz2, tar.gz, tar.gz, tar, bz2, gz, tbz2, tbz,"
            echo "tgz, lzo, rar, zip, 7z, xz and lzma." ;;
    esac
}
 
ad() { # decompress archive (to directory $2 if wished for and possible)
   if [ -f "$1" ] ; then
       case "$1" in
           *.tar.bz2|*.tgz|*.tbz2|*.tbz) mkdir -v "$2" 2>/dev/null ; tar xvjf "$1" -C "$2" ;;
       *.tar.gz)             mkdir -v "$2" 2>/dev/null ; tar xvzf "$1" -C "$2" ;;
       *.tar.xz)             mkdir -v "$2" 2>/dev/null ; tar xvJf "$1" ;;
       *.tar)             mkdir -v "$2" 2>/dev/null ; tar xvf "$1"  -C "$2" ;;
       *.rar)             mkdir -v "$2" 2>/dev/null ; 7z x   "$1"     "$2" ;;
       *.zip)             mkdir -v "$2" 2>/dev/null ; unzip   "$1"  -d "$2" ;;
       *.7z)             mkdir -v "$2" 2>/dev/null ; 7z x    "$1"   -o"$2" ;;
       *.lzo)             mkdir -v "$2" 2>/dev/null ; lzop -d "$1"   -p"$2" ;;  
       *.gz)             gunzip "$1"                       ;;
       *.bz2)             bunzip2 "$1"                       ;;
       *.Z)                 uncompress "$1"                       ;;
       *.xz|*.txz|*.lzma|*.tlz)     xz -d "$1"                           ;;
       *)              
       esac
   else
                      echo "Sorry, '$2' could not be decompressed."
              echo "Usage: ad <archive> <destination>"
              echo "Example: ad PKGBUILD.tar.bz2 ."
              echo "Valid archive types are:"
              echo "tar.bz2, tar.gz, tar.xz, tar, bz2,"
              echo "gz, tbz2, tbz, tgz, lzo,"
              echo "rar, zip, 7z, xz and lzma"
   fi
}
 
al() { # list content of archive but don't unpack
    if [ -f "$1" ]; then
         case "$1" in
       *.tar.bz2|*.tbz2|*.tbz) tar -jtf "$1"     ;;
       *.tar.gz)                     tar -ztf "$1"     ;;
       *.tar|*.tgz|*.tar.xz)                 tar -tf "$1"     ;;
       *.gz)                 gzip -l "$1"     ;;    
       *.rar)                 rar vb "$1"     ;;
       *.zip)                 unzip -l "$1"     ;;
       *.7z)                 7z l "$1"     ;;
       *.lzo)                 lzop -l "$1"     ;;  
       *.xz|*.txz|*.lzma|*.tlz)      xz -l "$1"     ;;
         esac
    else
         echo "Sorry, '$1' is not a valid archive."
     echo "Valid archive types are:"
     echo "tar.bz2, tar.gz, tar.xz, tar, gz,"
     echo "tbz2, tbz, tgz, lzo, rar"
     echo "zip, 7z, xz and lzma"
    fi
}
 
# Find file in current directory
function ff() {  find . -type f -iname '*'$*'*' -ls ; }
 
function zumbis() {
  ps f -eo state,pid,ppid,comm | awk '
    { cmds[$2] = $NF }
    /^Z/ { print $(NF-1) "/" $2 " zombie child of " cmds[$3] "/" $3 }'
}
 
# Powerfonts
if [[ -r/usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh
fi
#PS1='%(?.%F{green}.%F{red})%(!.#.>>>)%f '
#RPS1='[%B%F{blue}%~%f%b]'


#Aliases systemctl
alias service='systemctl list-unit-files | grep enable'
alias offservice='systemctl list-unit-files | grep disable'
 
#Aliase mpdviz
 
alias mpdviz='mpdviz --file="/tmp/mpd.fifo" --icolor=true --scale=2 --step=8 -v spectrum -d true'
 
#Aliases Git
alias ga='git add'
alias gcm='git commit -m'
alias gpom='git push origin master'
 
#Aliases - Shortcuts to commands
 alias ls='ls -CFb'
 alias la='ls -LaFb'
 alias ll='ls -lFb'
 alias dc='dcfldd'
 
#Several aliases
 alias saidar='saidar -c'  # pacman -S libstatgrab pystatgrab;
 #alias df='dfc -dTls' #pacman -S dfc
 #alias cp='vcp -gR' #cp advanced to support the progress blly, make sure the terminal is in application mode, when zle is
 
#Aliases  pacman
 alias pacsearch="pacman -Sl | cut -d' ' -f2 | grep " # It allows you to search all available packages simply using 'pacsearch packagename':
 alias pkglist="comm -13 <(pacman -Qmq | sort) <(pacman -Qqe | sort) > pkglist" # Create list of all installed packages
 alias pacup='sudo pacman -Syu' # Synchronises repositories and updates if you have any update
 alias pacre='sudo pacman -Rns' # Remove a specific package and all its dependencies and configurations
 alias pacorf='sudo pacman -Rns $(pacman -Qtdq)' # Create list of orphaned packages for removal
 alias pacin='sudo pacman -S' # Install a specific package
 
#Aliases  yaourt
 alias yaupg='yaourt -Syua' # Synchronises repositories and updates if you have any update by aur
 alias yain='yaourt -S' # Install a specific package
 alias yarem='yaourt -Rns' # Remove a specific package and all its dependencies and configurations
 alias yare='yaourt -R'  # Remove a specific package, but does not remove its dependencies and configurations
 
#Common errors
 alias cd..='cd ..'
 alias ...='cd ..'
 alias ....='cd ../..'
 
#May the force be with you
 alias starwars="telnet towel.blinkenlights.nl"
 
#Agenda    
 alias agenda='calcurse'
 
#Lists the last 10 commands executed in the shell
 alias top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
 
#Processos usados pela Web
 alias ports='lsof -i -n -P'
 
#Command help in the Zsh
  alias help='run-help'

alias systemctl reboot="sudo systemctl reboot"
alias systemctl poweroff="sudo systemctl poweroff"
alias systemctl halt="sudo systemctl halt"