# symlink dotfiles
./dotter deploy -f

# install yay and rust
sudo pacman -S vim git
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ~ && rm -rf yay
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# pacdef install all packages
yay -S pacdef
pacdef group import \
  ~/.config/pacdef/desktop \
  ~/.config/pacdef/term \
  ~/.config/pacdef/dev \
  ~/.config/pacdef/video
pacdef package sync


# install oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# docker
sudo systemctl enable docker 
sudo usermod -aG docker $USER

# load gnome config
dconf load / < desktop/gconf-settings.ini


# overide any dotfiles that were updated during install
./dotter deploy -f

sudo reboot now


