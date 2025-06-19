echo
tput setaf 2
echo "################################################################"
echo "################### Packages to install"
echo "################################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed nemo-git
sudo pacman -S --noconfirm --needed nemo-compare
sudo pacman -S --noconfirm --needed nemo-fileroller
sudo pacman -S --noconfirm --needed gnome-terminal-transparency
sudo pacman -S --noconfirm --needed gnome-terminal-transparency-debug
sudo pacman -S --noconfirm --needed sublime-text-4
sudo pacman -S --noconfirm --needed kitty-git
sudo pacman -S --noconfirm --needed gnome-logs
sudo pacman -S --noconfirm --needed mintstick-git
sudo pacman -S --noconfirm --needed oh-my-posh-bin
sudo pacman -S --noconfirm --needed fastfetch-git
sudo pacman -S --noconfirm --needed onevpl
sudo pacman -S --noconfirm --needed onevpl-cpu
sudo pacman -S --noconfirm --needed onevpl-intel-gpu
sudo pacman -S --noconfirm --needed vulkan-intel
sudo pacman -S --noconfirm --needed vulkan-tools
sudo pacman -S --noconfirm --needed vulkan-mesa-layers
sudo pacman -S --noconfirm --needed mesa-vdpau
sudo pacman -S --noconfirm --needed libva-intel-driver
sudo pacman -S --noconfirm --needed libva-utils
