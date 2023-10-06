#!/usr/bin/env bash

#NixOS rebuild
alias rebuild-os="sudo nixos-rebuild switch"

#Home-manager rebuild
alias rebuild-hm="home-manager switch"

#NixOS upgrade
alias upgrade-os="sudo nixos-rebuild switch --upgrade"

#Nix-env user update

alias update-os="nix-env -u '*'"

#Channels list, update, remove
alias channels="nix-channel --list"
alias channels-ad="nix-channel --add"
alias channels-up="nix-channel --update"
alias channels-rm="nix-channel --remove"

#Nixos collect-garbage
alias cleans="sudo nix-collect-garbage -d"

#User collect-garbage
alias cleanu="nix-collect-garbage -d"

#Delete specific nix store
alias nixstore-rm="sudo nix-store --delete --ignore-liveness"


alias generations="nix-env --list-generations"

alias pk="pkill -9"

alias ls="ls -al --color=auto"

alias lxappear="GDK_BACKEND=x11 lxappearance"

alias waybar-reload="waybar --bar main-bar --config ~/.config/hypr/waybar/configs/config-dual --style ~/.config/hypr/waybar/style/style-maroon.css &"

alias edit="subl"
alias sudo-edit="sudo -E subl"

delete_store() {
  store="$1"
  nix-store --query --referrers "$store" | xargs nix-store --delete
}

alias optimise="sudo nix-store --optimise"



alias install="nix-env -i"


alias shut="sudo shutdown -P 0"
alias reboot="sudo reboot now"

alias rebash="source ~/.bashrc"

neofetch