read -r -p " CMUS with CREATIVE PLAY! ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
echo -e "\e[1;36m OK \e[0m"
sudo apt-get install cmus -y
sudo cp ~/ipodrpi/system/alsa-base.conf /etc/modprobe.d/alsa-base.conf
sudo rm /etc/pikeyd.conf
sudo cp ~/ipodrpi/etc/pikeyd.conf.cmus /etc/pikeyd.conf
cmus &
cmus-remote -C "bind -f common u shell ~/.config/cmus/cmus-update.sh" &
cmus-remote -C "set softvol=true" &
sudo mkdir ~/Music
sudo cp ~/ipodrpi/system/rc ~/.config/cmus/rc
sudo cp ~/ipodrpi/system/cmus-update.sh ~/.config/cmus/cmus-update.sh
sudo chmod +x ~/.config/cmus/cmus-update.sh
echo "cmus" >> ~/.bashrc
#echo "~/.config/cmus/cmus-update.sh" >> ~/.bashrc
echo -e "\e[1;36m IF NO SOUND IN CMUS, SET IT UP IN RASPI-CONFIG \e[0m"
echo -e "\e[1;36m AND SET UP AUTOLOGIN IN RASPI-CONFIG \e[0m"
else
echo Skipping..
fi