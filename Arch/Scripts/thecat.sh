# adapted from z1lt0id https://github.com/z1lt0id/awesome/blob/master/thecat.sh

#!/bin/bash

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'

#gtkrc="$HOME/.gtkrc-2.0"
GtkTheme=$( grep "gtk-theme-name" ".gtkrc-2.0" | cut -d\" -f2 )
GtkIcon=$( grep "gtk-icon-theme-name" ".gtkrc-2.0" | cut -d\" -f2 )
GtkFont=$( grep "gtk-font-name" ".gtkrc-2.0" | cut -d\" -f2 )
Birthd=$(sed -n '1s/^\[\([0-9-]*\).*$/\1/p' /var/log/pacman.log | tr - .)
Wmname=$(wmctrl -m | grep -i name | awk '{print $2}')
System=$(cat /etc/os-release | sed '2,$d;s/NAME="//;s/"//')
Termfont=$(cat $HOME/.Xresources | grep -v ! | awk '/*font/ {print $2}' | sed 's/xft://;s/:pixelsize//;s/=/\ /')


KERNEL=$(uname -r)
PACKAGES=$(pacman -Q | wc -l)
FPACKAGES=$(pacman -Qqm | wc -l)
Gitdir="github.com/Morgareth"


cat << EOF   
$bld                                           
$f7                                                  
$f7                    .c0N.   .'c.                  $H the$f4 Hell's$f1 cat
$f7         'Okdl:'  ;OMMMMKOKNMMW:;o0l  .'.          
$f7         ;MMMMMMWWMMMMMMMMMMMMMMMMMXKWMMK         $f6 $USER $f7@ $f1$HOSTNAME
$f7         'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK         
$f7          NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO         $f2 Shell     »$f4 $SHELL
$f7          dMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:         $f2 Editor    »$f4 $EDITOR
$f7          'MMMMMMMMMMMMMMMMMMMMMMMMMMMMM.         $f2 Packages  »$f4 $PACKAGES $f1($FPACKAGES)$NC
$f7          'MMMMMMMMMMMMMMMMMMMMMMMMMMMMM;         $f2 Term      »$f4 $TERM
$f7          lMMMMM  MMMMMMMMMM  MMMMMMMMMM,         $f2 Termfont  »$f4 $Termfont
$f7          KMMMMM  MMMMMMMMMM  MMMMMMMMMM.         $f2 Gtkfont   »$f4 $GtkFont
$f7         ;WMMMMMkNMMMMMMMMMMONMMMMMMMMMW:         $f2 Theme     »$f4 $GtkTheme
$f7       oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO        $f2 Icons     »$f4 $GtkIcon
$f7      .,cxKWMMMMMMMMMMMMMMMMMMMMMMMMMMMXdxo        
$f7         ;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMM:          
$f7        .::,  .;ok0NMMMMWNK0kdoc;'  'cxK0         $f1 Kernel    »$f4 $KERNEL$NC
$f1                   .:cc:;;.                        WM        »$f4 $Wmname
$f1                   .o0MMMK'                        @         »$f7 $System
$f1                     xMMM:                         
$f1                     KMMMl                        
$f1                    .MMMMo                        $F2 Github    »$f4 $Gitdir
$f1                    ,MMMMx                        
$f1                    oMMMMx                        
$f1                    OMMMMO                        $f2 Be optimistic$f7, you idiot!
$f1                    .OMMMd                                                
$f1                      :Nl       
EOF