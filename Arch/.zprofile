
#Silent startx
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null

export PATH=$PATH:$HOME/.config/bspwm/panel/

export XTERM='termite'

