#!/bin/bash

sleep 1

BG_LOCATION="/home/sam/pictures/kanagawa.jpg"

# lenovo-artix only configuration
if [ "$HOSTNAME" = "lenovo-artix" ]; then
	xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1 # enable taps
	xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1 # reverse scrolling direction
	xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 0.25 # increase acceleration
	# xinput --set-prop "SynPS/2 Synaptics TouchPad" "Coordinate Transformation Matrix" 1.250000, 0.000000, 0.000000, 0.000000, 1.250000, 0.000000, 0.000000, 0.000000, 1.000000

	xrandr --output eDP --set TearFree on # remove screen tearing

	setxkbmap -option caps:swapescape # swap esc and caps lock

	libinput-gestures &

	# set brightness
	xbacklight -set 20
fi

# desktop only configuration
if [ "$HOSTNAME" = "sam-artix" ]; then
	# mouse settings
	xinput --set-prop "pointer:Logitech G Pro Gaming Mouse" "libinput Accel Speed" -1
	xinput --set-prop "pointer:Logitech G Pro Gaming Mouse" "Coordinate Transformation Matrix" 2.100000, 0.000000, 0.000000, 0.000000, 2.100000, 0.000000, 0.000000, 0.000000, 1.000000
	xinput --set-prop "pointer:Logitech G Pro Gaming Mouse" "libinput Scroll Method Enabled" 0, 0, 1

	xrandr --output DisplayPort-1 --mode 3440x1440 --rate 143.97 --set TearFree on

	BG_LOCATION="/home/sam/pictures/outer_space.png"
fi

# start dbus for playerctl & spotify, must be started early to allow programs opened by sxhkd to be listed in dbus
# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  # if not found, launch a new one
  eval `dbus-launch --sh-syntax --exit-with-session`
  echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

# keyboard delay & rate
xset r rate 200 60

# start various programs in the background
feh-blur --blur 4 --darken 0 -d
feh --bg-fill $BG_LOCATION &

# pipewire for audio
pipewire &
pipewire-pulse &
wireplumber &

picom --backend xrender --fading --fade-delta=5 &
redshift -l 36.15:-97.38 &
ntfd & # weather for polybar

# fixed for large cursor
xrdb -merge ~/.Xresources

# turn off the screen after x seconds
xset dpms 0 0 60

# screensaver
#xscreensaver &

# greenclip for clipboard management with rofi
# installed from aur under rofi-greenclip
greenclip daemon &

# autorandr to update the display configuration
autorandr --change 2023-vert

# start window manager
#exec dwm
exec bspwm -c ~/.config/bspwm/bspwmrc
