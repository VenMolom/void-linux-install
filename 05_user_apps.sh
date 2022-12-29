xbps-install -Syu firefox wezterm gcc cmake fd bat ripgrep delta rsync unzip yarn nodejs wofi

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir ~/.zfunc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

# rust and completions
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup completions zsh > ~/.zfunc/_rustup
rustup completions zsh cargo > ~/.zfunc/_cargo

# nvim
cargo install bob-nvim
bob install stable

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# fzf
xbps-install -Syu fzf


