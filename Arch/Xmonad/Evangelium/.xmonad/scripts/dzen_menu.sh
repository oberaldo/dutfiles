#!/bin/bash
Nama1="Image Viewer"
Exec1="viewnior"
Nama2="File Manager"
Exec2="thunar"
Nama3="Pdf Reader"
Exec3="zathura"
Nama4="Media Player"
Exec4="gnome-mpv"
Nama5="Change Wallpaper"
Exec5="nitrogen"
Nama6="Messenger"
Exec6="telegram-desktop"
Nama7="Word Processing"
Exec7="abiword"
Nama8="Text Editor"
Exec8="atom"
Nama9="Sound"
Exec9="pavucontrol"
Nama10="Power Menu"
Exec10="oblogout"
Y=768
space="   "
Font="Exo 2-8"
Title="Menu"
BG=#2D2D2D
FG=#fcfcfc
IconTitle="/home/tiago/.xmonad/icons/menu.xbm"
(echo "^ro(0)^ib(1)$space^i($IconTitle)$space$Title" ;echo -e "\
\n^ca(1,$Exec1)$space$Nama1^pa(117)^ca()\
\n^ca(1,$Exec2)$space$Nama2^pa(117)^ca()\
\n^ca(1,$Exec3)$space$Nama3^pa(117)^ca()\
\n^ca(1,$Exec4)$space$Nama4^pa(117)^ca()\
\n^ca(1,$Exec5)$space$Nama5^pa(117)^ca()\
\n^ca(1,$Exec6)$space$Nama6^pa(117)^ca()\
\n^ca(1,$Exec7)$space$Nama7^pa(117)^ca()\
\n^ca(1,$Exec8)$space$Nama8^pa(117)^ca()\
\n^ca(1,$Exec9)$space$Nama9^pa(117)^ca()\
\n^ca(1,$Exec10)$space$Nama10^pa(117)^ca()")\
| dzen2 -y "$Y" -fn "$Font" -bg "$BG" -fg "$FG" -l 10 -tw 60 -ta l -w 120 -h 24 -m -p -e 'entertitle=;enterslave=grabkeys;leaveslave=collapse,ungrabkeys;button1=uncollapse,grabkeys;button2=togglestick;button3=;button4=scrollup;button5=scrolldown;key_Escape=ungrabkeys'
