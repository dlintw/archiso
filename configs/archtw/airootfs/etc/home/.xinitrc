# ~/.xinitrc
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#xset s off
numlockx &

#export LANG=en_US.UTF-8 # for English interface
export LANG=zh_TW.UTF-8
export LC_CTYPE=zh_TW.UTF-8

mkdir -p ~/tmp/log

# Chinese Input Method {{{1
export GTK_IM_MODULE=gcin
export QT_IM_MODULE=gcin
export XMODIFIERS=@im=gcin
LANG=zh_TW.UTF-8 gcin &
export OOO_FORCE_DESKTOP="gnome"

# daemons {{{1
wicd-client&
clipit -d&
#pcmanfm --desktop-pref  <-- use this to configure
pcmanfm --desktop -d & #-d:support USB automount (package udiskie & gvfs required)

# my apps {{{1
#xombrero&
#lxterminal&
#lilyterm&
#sudo gparted &
lxpanel > ~/tmp/log/lxpanel.log 2>&1 &

# monitor on left
xrandr --output LVDS1 --auto --pos 0x0 --output VGA1 --auto --left-of LVDS1

/usr/bin/VBoxClient-all

exec openbox > ~/tmp/log/openbox.log 2>&1

# vim:et sw=2 ts=2 ai nocp sta
