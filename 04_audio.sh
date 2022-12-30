#! /bin/sh

xbps-install -Syu pipewire alsa-pipewire pamixer pavucontrol libjack-pipewire

mkdir -p /etc/alsa/conf.d
ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

cp -r /usr/share/pipewire /etc/pipewire
sed -i "s/#\({ path = \".*\" args = \".*\" }\)/\1/" /etc/pipewire/pipewire.conf

echo "/usr/lib/pipewire-0.3/jack" > /etc/ld.so.conf.d/pipewire-jack.conf
ldconfig
