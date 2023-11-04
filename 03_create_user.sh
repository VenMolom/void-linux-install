#! /bin/sh

xbps-install -Sy zsh
useradd -m -G wheel,input,video,audio -s /bin/zsh molom
passwd molom

cp -r /usr/void-linux-install /home/molom/
