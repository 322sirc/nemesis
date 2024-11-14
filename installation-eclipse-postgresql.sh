#!/bin/bash
sudo apt -update && sudo apt -upgrade && 
sleep 1

echo "install wget"
sudo apt install -y wget &&
sleep 1

echo "
----------------------------------------------------------------------------------------------------------
----------------------------install Eclipse latest version!-----------------------------------------------
----------------------------------------------------------------------------------------------------------"
wget https://download.eclipse.org/oomph/products/latest/eclipse-inst-jre-linux64.tar.gz
tar -xvzf eclipse-inst*.tar.gz
cd eclipse-installer
./eclipse-inst &&
sleep1



#postgresql server module

echo "----------------------------------------------------------------
Postgresql WILL be installed and configured!--------------------------
----------------------------------------------------------------------"
sleep 1

sudo apt install -y postgresql-common postgresql-contrib &&
sleep1

echo "----------------------------------------------------------------
Postgresql installation WAS complated!--------------------------------
----------------------------------------------------------------------"

sleep 2
echo "--------Change password of postgres user------
----------------------------------------------------"
sudo -u postgres psql --command '\password postgres' &&
sleep 1



echo "
----------------------------------------------------------------------------------------------------------
----------------------------install DBeaver 24.2.4 version!-----------------------------------------------
----------------------------------------------------------------------------------------------------------"

wget https://dbeaver.io/files/24.2.4/dbeaver-ce_24.2.4_amd64.deb &&
sudo dpkg -i dbeaver-*.deb &&
dbeaver