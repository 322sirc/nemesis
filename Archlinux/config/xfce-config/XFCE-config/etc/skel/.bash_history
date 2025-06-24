dconf write /org/gnome/Ptyxis/Profiles/aca62ac9eb0beedb789dc82c6850b9ab/opacity 0.85
dconf write /org/gnome/Ptyxis/Profiles/aca62ac9eb0beedb789dc82c6850b9ab/opacity 0.88
cp -r /usr/share/fastfetch/presets/all.json ~/.config/fastfetch/
cp -r /usr/share/fastfetch/presets/all.jsonc ~/.config/fastfetch/
mkdir ~/.config/fastfetch
cp -r /usr/share/fastfetch/presets/all.jsonc ~/.config/fastfetch/
pacman -Qe | cut -d' ' -f1 > packages-add-1
sudo subl /etc/security/pam_env.conf
env MOZ_USE_XINPUT2=1 firefox
sudo sed -i "s|Exec=|Exec=env MOZ_USE_XINPUT2=1 |g" /usr/share/applications/firefox.desktop
