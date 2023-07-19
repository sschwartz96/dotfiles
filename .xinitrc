#!/bin/bash

sleep 1

# mouse settings
xinput --set-prop "pointer:Logitech G Pro Gaming Mouse" "libinput Accel Speed" -1
xinput --set-prop "pointer:Logitech G Pro Gaming Mouse" "Coordinate Transformation Matrix" 2.100000, 0.000000, 0.000000, 0.000000, 2.100000, 0.000000, 0.000000, 0.000000, 1.000000
xinput --set-prop "pointer:Logitech G Pro Gaming Mouse" "libinput Scroll Method Enabled" 0, 0, 1

# set trackpad settings
synclient VertScrollDelta=-66	# natural scrolling
synclient TapAndDragGesture=1
synclient TapButton1=1
synclient TapButton2=3
synclient PalmDetect=1
synclient PalmMinWidth=4
synclient PalmMinZ=50
synclient MinSpeed=1.5
synclient HorizTwoFingerScroll=1

if [ "$HOSTNAME" = "lenovo-artix" ]; then
	xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1 # enable taps
	xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1 # reverse scrolling direction
	xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 0.25 # increase acceleration
	# xinput --set-prop "SynPS/2 Synaptics TouchPad" "Coordinate Transformation Matrix" 1.250000, 0.000000, 0.000000, 0.000000, 1.250000, 0.000000, 0.000000, 0.000000, 1.000000

	xrandr --output eDP --set TearFree on # remove screen tearing

	setxkbmap -option caps:swapescape # swap esc and caps lock

	libinput-gestures &
fi

# set brightness
xbacklight -set 25

# turn off trackpad when typing
syndaemon -i 0.2 -K -t -d

# start dbus for playerctl & spotify, must be started early to allow programs opened by sxhkd to be listed in dbus
# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  # if not found, launch a new one
  eval `dbus-launch --sh-syntax --exit-with-session`
  echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

### KEYBOARD
# keyboard delay & rate
xset r rate 200 60

# don't swap on desktop due to new keyboard
if [ "$HOSTNAME" = "sam-lap" ]
then
	setxkbmap -option caps:swapescape # swap esc and caps lock

	# libinput-gestures for touchpad swipes
	libinput-gestures &
fi

# alt + hjkl {left down up left}
#xmodmap ~/.key_maps


# start various programs in the background
feh --bg-center pictures/background.jpg &
feh-blur --blur 4 --darken 0 -d
# pipewire for audio
pipewire &
pipewire-pulse &
wireplumber &

picom --fading --fade-delta=5 &
redshift -l 36.15:-97.38 &
ntfd & # weather for polybar
#sxhkd > /home/sam/.config/sxhkd/sxhkd.log &
#~/scripts/set_status.sh &
numlockx on

# fixed for large cursor
xrdb -merge ~/.Xresources

# turn off the screen after x seconds
xset dpms 0 0 6000

# screensaver
#xscreensaver &

# greenclip for clipboard management with rofi
# installed from aur under rofi-greenclip
greenclip daemon &

# autorandr to upddate the display configuration
autorandr --change

# start window manager
#exec dwm
exec bspwm -c ~/.config/bspwm/bspwmrc
