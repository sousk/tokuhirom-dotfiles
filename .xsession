# XIM_PROGRAM_XTRA=uim-toolbar-gtk-systray
export XMODIFIERS=@im=uim
uim-xim &
GTK_IM_MODULE=uim ; export GTK_IM_MODULE
UIM_IM_ENGINE=skk ; export UIM_IM_ENGINE

# (普段 Gnome を使っている場合は)キーボードやディスプレイの設定を有効にしてくれる
gnome-settings-daemon &

# 勝手に無線LANに接続してくれる
nm-applet &

gnome-power-manager &
gnome-volume-manager &
# nautilus -n & 
# pidgin &
# dropbox start -i &
update-notifier --startup-delay=60 &

# exec /usr/bin/stumpwm
