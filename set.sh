#!/bin/bash
#

echo
tput setaf 1
echo "################################################################"
echo "#####  Choose wisely - one time setup after clean install   ####"
echo "################################################################"
tput sgr0
echo
echo "Select the correct desktop"
echo
echo "0.  Do nothing"
echo "1.  Cris"
echo "Type the number..."

read CHOICE

case $CHOICE in

    0 )
      echo
      echo "########################################"
      echo "We did nothing as per your request"
      echo "########################################"
      echo
      ;;

    1 )
			git config --global pull.rebase false
			git config --global push.default simple
			git config --global user.name "cristina223"
			git config --global user.email "cristina223@gmail.com"
			sudo git config --system core.editor nano
			git config --global credential.helper cache
			git config --global credential.helper 'cache --timeout=32000'
      echo
      echo "Everything set"
      ;;
    * )
      echo "#################################"
      echo "Choose the correct number"
      echo "#################################"
      ;;
esac

echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
