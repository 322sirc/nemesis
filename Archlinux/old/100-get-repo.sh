if grep -q 322sirc /etc/pacman.conf; then

  echo
  tput setaf 2
  echo "################################################################"
  echo "################### repo is already in /etc/pacman.conf"
  echo "################################################################"
  tput sgr0
  echo

else

  tput setaf 2
  echo "################################################################"
  echo "################### repo added to /etc/pacman.conf"
  echo "################################################################"
  tput sgr0

echo '
[repo]
SigLevel = Never
Server = https://322sirc.github.io/$repo/$arch' | sudo tee --append /etc/pacman.conf

sudo pacman -Sy

fi