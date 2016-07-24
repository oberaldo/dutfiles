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
alias cp='vcp -gR' #cp advanced to support the progress blly, make sure the terminal is in application mode, when zle is
                          
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
                                              
#Processos usados pela Web
alias ports='lsof -i -n -P'
                                                  
#Coloring the cat command  # pacman  -S lolcat
alias cat='lolcat'
                                                     
