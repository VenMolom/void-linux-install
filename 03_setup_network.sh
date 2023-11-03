#! /bin/sh

ln -s /etc/sv/dhcpcd /var/service/
xbps-install -S

xbps-install -Syu ufw ufw-extras
ln -s /etc/sv/ufw /var/service/
ufw enable
ufw default deny