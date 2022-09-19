if [[ $(grep -L "#" /etc/modules-load.d/anbox.conf) ]]; then
   echo "anbox modules are loaded already"
else   
sudo sed -i 's/^#//' /etc/modules-load.d/anbox.conf
fi
