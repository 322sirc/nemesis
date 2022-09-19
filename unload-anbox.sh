
if grep -q "#" /etc/modules-load.d/anbox.conf; then
   echo "anbox modules are unloaded already"
else   
 sudo sed -i 's/^/#/' /etc/modules-load.d/anbox.conf

fi