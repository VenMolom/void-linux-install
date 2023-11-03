#! /bin/sh

# fonts
xbps-install -Suy google-fonts-ttf font-awesome6 nerd-fonts-ttf

# elogind - seat manager
xbps-install dbus elogind
ln -s /etc/sv/dbus /var/service/

# xorg
xbps-install -Suy xorg-minimal

# i3 and fallback default apps
xbps-install -Suy i3 i3status dmenu rxvt-unicode

echo "exec i3" >> /home/molom/.xinitrc