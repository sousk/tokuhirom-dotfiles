/usr/X11/bin/skkinput &
/usr/X11R6\ 1/bin/xmodmap $HOME/.Xmodmap
export LANG=ja_JP.UTF-8
export XMODIFIERS="@im=skkinput"

xset +fp /opt/local/share/fonts/monafont/:unscaled
xset fp rehash

# /opt/local/bin/urxvt &
# /opt/local/bin/urxvt &
# exec ratpoison
# quartz-wm --only-proxy &
exec /usr/bin/stumpwm
# exec quartz-wm
