#!/bin/bash

set -euo pipefail

### === CONFIGURATION === ###
HOSTNAME="myarch"
USERNAME="cris"
USERGROUPS="wheel,audio,video,network,storage,input,lp,optical,sys,log,rfkill"
LOCALE="en_US.UTF-8"
TIMEZONE="America/Toronto"
ROOT_PART="/dev/sda2"
EFI_PART="/dev/sda1"
MOUNT_ROOT="/mnt"

### === FORMAT & MOUNT === ###
echo "[+] Preparing partitions..."

# Prompt: root filesystem format
read -rp "❓ Format root partition ($ROOT_PART) as ext4 or xfs? [ext4/xfs]: " ROOT_FS
ROOT_FS="${ROOT_FS,,}"  # to lowercase

if [[ "$ROOT_FS" != "ext4" && "$ROOT_FS" != "xfs" ]]; then
    echo "❌ Invalid choice: $ROOT_FS. Must be ext4 or xfs. Aborting."
    exit 1
fi

echo "[+] Formatting root partition ($ROOT_PART) as $ROOT_FS..."

if [[ "$ROOT_FS" == "ext4" ]]; then
    mkfs.ext4 -F "$ROOT_PART"
else
    mkfs.xfs -f "$ROOT_PART"
fi

# Prompt: EFI format
read -rp "❓ Do you want to format the EFI partition ($EFI_PART)? [y/N]: " FORMAT_EFI
FORMAT_EFI="${FORMAT_EFI,,}"

if [[ "$FORMAT_EFI" == "y" || "$FORMAT_EFI" == "yes" ]]; then
    echo "[+] Formatting EFI partition: $EFI_PART..."
    mkfs.fat -F32 "$EFI_PART"
else
    echo "⚠️ Skipping EFI partition format. It will only be mounted."
fi

# Mounting
echo "[+] Mounting root and EFI partitions..."
mount "$ROOT_PART" "$MOUNT_ROOT"
mkdir -p "$MOUNT_ROOT/boot/efi"
mount "$EFI_PART" "$MOUNT_ROOT/boot/efi"


### === BASE INSTALL === ###
echo "[+] Installing base system..."
pacstrap -K "$MOUNT_ROOT" base reflector linux linux-headers linux-firmware-intel sudo grub efibootmgr nano iwd networkmanager --noconfirm

### === FSTAB === ###
echo "[+] Generating fstab..."
genfstab -U "$MOUNT_ROOT" >> "$MOUNT_ROOT/etc/fstab"

### === CHROOT & CONFIGURATION === ###
cat <<EOF | arch-chroot "$MOUNT_ROOT"

# Set hostname
echo "$HOSTNAME" > /etc/hostname

# Set locale
echo "$LOCALE UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=$LOCALE" > /etc/locale.conf

# Set the console keyboard layout
echo "FONT=ter-132b
KEYMAP=us" > /etc/vconsole.conf

# Set timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# Create user
useradd -m -G $USERGROUPS -s /bin/bash $USERNAME
echo "$USERNAME:arch" | chpasswd
echo "root:arch" | chpasswd

# Enable sudo
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Install and configure GRUB
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
mkdir -p /boot/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Enable networking
systemctl enable NetworkManager

EOF
# Copy Data scripts configuration to the new system
echo "[+] Copy folder Data in the new system"
cp -a /root/Data "$MOUNT_ROOT"
chmod -R 777 "$MOUNT_ROOT"/Data

### === DONE === ###
echo "[+] Installation complete. You can now reboot."
echo "Default user: $USERNAME / arch"
echo "Default root password: arch"
#echo "Run: umount -R $MOUNT_ROOT && reboot"
