#!/bin/bash

set -euo pipefail

# Base directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[*] Using script directory: $SCRIPT_DIR"

# Replace pacman.conf
if [[ -f "$SCRIPT_DIR/pacman.conf" ]]; then
    echo "[*] Replacing pacman.conf..."
    sudo cp /etc/pacman.conf /etc/pacman.conf.bak
    sudo cp "$SCRIPT_DIR/pacman.conf" /etc/pacman.conf
    sudo pacman -Syy
else
    echo "⚠️ pacman.conf not found in $SCRIPT_DIR"
fi

# Install core kernel packages first
echo "[*] Installing core kernel packages..."
sudo pacman -S --noconfirm --needed linux linux-headers linux-firmware mkinitcpio

# Detect and install CPU microcode
echo "[*] Detecting CPU microcode..."
if grep -q "AuthenticAMD" /proc/cpuinfo; then
    echo "Installing AMD microcode..."
    sudo pacman -S --noconfirm --needed amd-ucode
elif grep -q "GenuineIntel" /proc/cpuinfo; then
    echo "Installing Intel microcode..."
    sudo pacman -S --noconfirm --needed intel-ucode
fi

# Install remaining packages from the list
PKG_LIST="$SCRIPT_DIR/packages.x86_64"

if [[ ! -f "$PKG_LIST" ]]; then
    echo "❌ Error: packages.x86_64 not found!"
    exit 1
fi

echo "[*] Installing packages from packages.x86_64..."
SKIP_PKGS=("linux" "linux-headers" "linux-firmware" "mkinitcpio" "intel-ucode" "amd-ucode")

while IFS= read -r package; do
    [[ -z "$package" || "$package" == \#* ]] && continue
    if [[ " ${SKIP_PKGS[*]} " =~ " ${package} " ]]; then
        continue
    fi
    echo "Installing: $package"
    sudo pacman -S --noconfirm --needed "$package" || echo "⚠️ Failed to install $package"
done < "$PKG_LIST"

# Enable essential services
echo "[*] Enabling essential services..."
sudo systemctl enable sddm power-profiles-daemon bluetooth NetworkManager

# Install SDDM session config
# Ensure the SDDM config directory exists
if [[ ! -d /etc/sddm.conf.d ]]; then
    echo "[*] Creating /etc/sddm.conf.d directory..."
    sudo mkdir -p /etc/sddm.conf.d
fi

# Then, if the Xfce.session file exists in the script dir, copy it
if [[ -f "$SCRIPT_DIR/Xfce.session" ]]; then
    echo "[*] Installing SDDM session file..."
    sudo cp "$SCRIPT_DIR/Xfce.session" /etc/sddm.conf.d/
else
    echo "⚠️  Xfce.session file not found in $SCRIPT_DIR"
fi

# Configure GRUB
if [ -d "/boot/grub" ]; then
    echo "GRUB detected. Proceeding with theme installation and configuration..."
    sudo sed -i 's/#\s*GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
    sudo ./grub.sh
    sudo grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "GRUB not detected. Skipping customize grub."
fi
sleep 2
#
#echo "[*] Updating GRUB settings..."
#sudo sed -i 's/#\s*GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub || true
#echo "GRUB_THEME=/usr/share/grub/themes/theme.txt" | sudo tee -a /etc/default/grub > /dev/null
#sudo grub-mkconfig -o /boot/grub/grub.cfg

# VM detection and guest tools
virt=$(systemd-detect-virt || echo "none")
if [[ "$virt" != "none" ]]; then
    echo "[*] VM detected — installing guest tools..."
    sudo pacman -S --noconfirm --needed virtualbox-guest-utils
fi

# Regenerate initramfs
echo "[*] Regenerating initramfs..."
sudo mkinitcpio -P

# Done
echo
echo "✅ Installation and configuration complete!"
echo "💡 You can now reboot into your fully configured Arch Linux system."
