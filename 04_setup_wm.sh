#! /bin/sh

# fonts
xbps-install -Suy google-fonts-ttf font-awesome6 nerd-fonts-ttf

# elogind - seat manager
xbps-install =-Suy dbus elogind
ln -s /etc/sv/dbus /var/service/

# utils
xbps-install -Syu dex xrandr

# xorg
xbps-install -Suy xorg-minimal

# i3 and fallback default apps
xbps-install -Suy i3 i3status dmenu rxvt-unicode
