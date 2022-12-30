#! /bin/sh

# prepare
sudo xbps-install -Syu gcc cmake rsync unzip yarn nodejs xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk xdg-utils libva

# browser and terminal
sudo xbps-install -Syu firefox wezterm wezterm-terminfo

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir ~/.zfunc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

# rust and completions
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup completions zsh > ~/.zfunc/_rustup
rustup completions zsh cargo > ~/.zfunc/_cargo

# launcher and console apps
sudo xbps-install -Syu wofi btop ranger

# nvim
cargo install bob-nvim
bob install stable

# nvim tools
sudo xbps-install -Syu fd bat ripgrep delta

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# fzf
xbps-install -Syu fzf

# flatpak and discord
sudo xbps-install -Syu flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.discordapp.Discord

# music
sudo xbps-install -Syu pkg-config alsa-lib-devel libssh-devel libssh2-devel dbus-devel ueberzug libxcb libxcb-devel playerctl
cargo install librespot ncspot
