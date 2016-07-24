    #!/bin/sh
    # switch power state using dmenu
    options='lock
    poweroff
    reboot
    suspend
    '
    sel=$(printf '%s' "${options}" \
    	| dmenu -x 0  -y 24 -w 180 -l 5 -h 16 -i -fn 'xft:FontAwesome:pixelsize=10' 
    )
    case "${sel}" in
    	poweroff|reboot)
    		sudo "${sel}"
    		;;
    	lock|suspend)
    		"${sel}"
    		;;
    esac