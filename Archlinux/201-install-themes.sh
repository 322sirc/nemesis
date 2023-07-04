echo
tput setaf 2
echo "################################################################"
echo "################### Installing software themes packages"
echo "################################################################"
tput sgr0
echo
sudo pacman -S --noconfirm --needed jq	
sudo pacman -S --noconfirm --needed lm_sensors
sudo pacman -S --noconfirm --needed conky-lua-archers-git
#sudo pacman -S --noconfirm --needed nerd-fonts-hack
sudo pacman -S --noconfirm --needed Arc-Froly-Dark-gtk-theme
sudo pacman -S --noconfirm --needed fluent-round-icon-theme-git
sudo pacman -S --noconfirm --needed sunset-mine-kde
sudo pacman -S --noconfirm --needed catppuccin-cursors-git
sudo pacman -S --noconfirm --needed catppuccin-gtk-theme-frappe
sudo pacman -S --noconfirm --needed wallpapers-personal
sudo pacman -S --noconfirm --needed kvantum-theme-catppuccin-git
sudo pacman -S --noconfirm --needed sddm-theme-catppuccin