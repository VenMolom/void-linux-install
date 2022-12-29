#! /bin/sh

xbps-install -Sy zsh zsh-autosuggestions zsh-completions
useradd -m -G wheel,input,video,audio,shutdown -s /bin/zsh molom
passwd molom
