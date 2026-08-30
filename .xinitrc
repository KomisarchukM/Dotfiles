#!/bin/sh
pulseaudio --start &						                #audio
sxhkd &								                        #keybinds
feh --bg-fill ~/wallpaper.jpg &					            #wallpaper
setxkbmap -layout "us,ua" -option "grp:caps_toggle" &		#languages
picom --config ~/.config/picom/picom.conf -b &			    #picom
/home/s1nshen/.config/polybar/launch.sh	&			        #polybar
exec bspwm							                        #wm
