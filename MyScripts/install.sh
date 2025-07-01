#!/bin/bash

set -euo pipefail

# Log all output (stdout and stderr) to a file
LOGFILE="/var/log/custom_install.log"
exec > >(tee -a "$LOGFILE") 2>&1


# Packages list name -based on the desktop
LIST_NAME="XFCE-packages.x86_64-categ"
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

PKG_LIST="$SCRIPT_DIR/$LIST_NAME"

# Check if file exists
if [[ ! -f "$PKG_LIST" ]]; then
    echo "❌ Error: $LIST_NAME not found in $SCRIPT_DIR!"
    exit 1
fi

echo "[*] Installing packages from $LIST_NAME..."
SKIP_PKGS=("linux" "linux-headers" "linux-firmware-intel" "mkinitcpio" "intel-ucode")

# Read and install packages
while IFS= read -r package; do
    # Skip empty lines and comments
    [[ -z "$package" || "$package" == \#* ]] && continue

    # Skip certain packages
    if [[ " ${SKIP_PKGS[*]} " =~ " ${package} " ]]; then
        echo "⏭️ Skipping: $package"
        continue
    fi

    echo "📦 Installing: $package"
    sudo pacman -S --noconfirm --needed "$package" || echo "⚠️ Failed to install $package"
done < "$PKG_LIST"

# Copy custom skel contents to user home
USER_NAME="cris"
USER_HOME="/home/$USER_NAME"

echo "[*] Applying /etc/skel to $USER_HOME..."

if id "$USER_NAME" &>/dev/null; then
    if [[ -d "$USER_HOME" ]]; then
        sudo cp -a /etc/skel/. "$USER_HOME/"
        sudo cp -a /etc/skel/. "/root/"
        sudo rm "$USER_HOME/.bashrc"
        sudo mv "$USER_HOME/.bashrc_profile" "$USER_HOME/.bashrc"
        sudo chown -R "$USER_NAME:$USER_NAME" "$USER_HOME"
       
        sudo rm /root/.bashrc
        sudo mv /root/.bashrc_profile /root/.bashrc
        sudo rm /etc/environment
        sudo mv /etc/environment_profile /etc/environment
                

        echo "✅ Custom skel applied to $USER_NAME"
    else
        echo "⚠️ User $USER_NAME exists but $USER_HOME does not. Skipping skel copy."
    fi
else
    echo "❌ User $USER_NAME does not exist! Skipping skel copy."
fi


# Enable essential services
echo "[*] Enabling essential services..."
sudo systemctl enable sddm power-profiles-daemon bluetooth NetworkManager


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

echo "Disabling 'debug' in makepkg.conf options..."
if grep -q 'OPTIONS=.*\bdebug\b' /etc/makepkg.conf && ! grep -q 'OPTIONS=.*!debug' /etc/makepkg.conf; then
    sudo sed -i -E 's/(OPTIONS=.*[ (])debug([ )])/\1!debug\2/' /etc/makepkg.conf
fi


# Define the list of desired groups
#EXTRA_GROUPS="wheel audio video storage network input lp optical sys log rfkill"

# Detect the first non-system user (UID >= 1000)
#NEW_USER=$(awk -F: '$3 >= 1000 && $3 < 65534 { print $1; exit }' /etc/passwd)

## Check if we found a user
#if [[ -z "$NEW_USER" ]]; then
#    echo "❌ No user with UID >= 1000 found."
#    exit 1
#fi
#
#echo "👤 Detected user: $NEW_USER"
#echo "🔍 Ensuring groups exist..."
#
## Create any missing groups
#for grp in $EXTRA_GROUPS; do
#    if getent group "$grp" > /dev/null; then
#        echo "✅ Group '$grp' already exists."
#    else
#        echo "➕ Creating group '$grp'..."
#        sudo groupadd "$grp"
#    fi
#done
#
#echo "👥 Adding user '$NEW_USER' to groups..."
#sudo usermod -aG "$(echo "$EXTRA_GROUPS" | tr ' ' ,)" "$NEW_USER"
#
#echo "✅ Done. User '$NEW_USER' is now in the following groups:"
#id "$NEW_USER"
#

# Done
echo
echo "✅ Installation and configuration complete!"
echo "💡 You can now reboot into your fully configured Arch Linux system."

echo
echo "📋 Extracting error messages from log..."
grep -iE "error|failed|not found|cannot" "$LOGFILE" > /var/log/custom_install_errors.log || true

if [[ -s /var/log/custom_install_errors.log ]]; then
    echo "⚠️  Detected possible issues. Review /var/log/custom_install_errors.log:"
    cat /var/log/custom_install_errors.log
else
    echo "✅ No significant errors found in log."
fi

