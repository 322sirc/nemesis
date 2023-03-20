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
  sudo pacman -R --noconfirm amd-ucode
  sudo pacman -R --noconfirm cryptsetup
  sudo pacman -R --noconfirm btrfs-progs
  sudo pacman -Rs --noconfirm dmraid
  sudo pacman -Rs --noconfirm hplip
  sudo pacman -Rs --noconfirm piper

  echo
  tput setaf 2
  echo "################################################################"
  echo "################### Software removed"
  echo "################################################################"
  tput sgr0
  echo

fi
