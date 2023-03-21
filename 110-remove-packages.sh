# when on Xerolinux - remove conflicting files 

if grep -q "XeroLinux" /etc/os-release; then

  echo
  tput setaf 2
  echo "################################################################"
  echo "################### Removing software from Xerolinux"
  echo "################################################################"
  tput sgr0
  echo
  
  #if [ -f /etc/skel/.bashrc ]; then
  #  sudo rm /etc/skel/.bashrc
  #fi  
  sudo pacman -Rs --noconfirm printer-support
  sudo pacman -Rs --noconfirm hplip
  sudo pacman -Rs --noconfirm piper
  sudo pacman -R --noconfirm game-devices-udev
  sudo pacman -Rs --noconfirm kdenetwork-filesharing
  sudo pacman -Rs --noconfirm gvfs-smb
  sudo pacman -Rs --noconfirm kitty-terminfo
  #sudo pacman -R --noconfirm btrfs-progs
  #sudo pacman -Rs --noconfirm dmraid

  echo
  tput setaf 2
  echo "################################################################"
  echo "################### Software removed"
  echo "################################################################"
  tput sgr0
  echo

fi
