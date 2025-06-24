if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias update='sudo pacman -Syyu'
alias install="sudo pacman -S"
alias remove="sudo pacman -Rs"
alias cleanup='sudo pacman -Scc'
alias upsum="updpkgsums"
alias mkinstall="makepkg -sic"
alias locinstall="sudo pacman -U"
alias bash-refresh="source ~/.bashrc"
alias refresh-keys='sudo pacman-key --refresh-keys'
alias mirror="rate-mirrors --allow-root --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist && sudo pacman -Sy"
alias unlock="sudo rm /var/lib/pacman/db.lck"

alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"

#git
alias clone="git clone"
alias gcl="git clone"
alias repoup="repo-add repo.db.tar.gz *.pkg.tar.zst"
alias gitup="./git-v2.sh"
alias gitset="./setup.sh"

##Performance
alias balance="powerprofilesctl set balanced"
alias performance="powerprofilesctl set performance"
alias power-saver="powerprofilesctl set power-saver"

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

alias lxorg="bat /var/log/Xorg.0.log"
alias lxorgo="bat /var/log/Xorg.0.log.old"
alias npacman="sudo $EDITOR /etc/pacman.conf"
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias wget="wget -c"

alias rate-mirror="rate-mirrors --allow-root --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist && sudo pacman -Sy"
alias rate-mirrors="rate-mirrors --allow-root --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist && sudo pacman -Sy"
fastfetch
set -g fish_greeting