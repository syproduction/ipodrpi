#!/bin/bash

#screen

echo -e "\e[1;36m iPod Raspberry Pi with 2 inch LCD and CLICKWHEEL installer  \e[0m"
echo -e "\e[1;36m by Niels Bor @ DARKMATTERWORKS  \e[0m"

read -r -p "OSMC? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
echo -e "\e[1;36m DISABLING OSMC REPOSITORY (BECAUSE OF LIBC6 ERROR)  \e[0m"
sudo bash -c 'echo "deb http://mirrordirector.raspbian.org/raspbian buster main contrib non-free rpi" > /etc/apt/sources.list'
else
echo -e "\e[1;36m SUPPOSING WE ARE ON RASPBIAN  \e[0m"
fi

read -r -p "Add Adding 2inch display parameters to /boot/config.txt ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
echo -e "\e[1;36m Ok, writing to /boot/config.txt   \e[0m"
sudo bash -c 'echo "enable_uart=1" >> /boot/config.txt'
sudo bash -c 'echo "hdmi_force_hotplug=1" >> /boot/config.txt'
sudo bash -c 'echo "hdmi_cvt=320 240 60 1 0 0 0" >> /boot/config.txt'
sudo bash -c 'echo "hdmi_group=2" >> /boot/config.txt'
sudo bash -c 'echo "hdmi_mode=1" >> /boot/config.txt'
sudo bash -c 'echo "hdmi_mode=87" >> /boot/config.txt'
sudo bash -c 'echo "display_rotate=0" >> /boot/config.txt'
else
echo Skipping..
fi

echo -e "\e[1;36m APT UPDATE & UPGRADE  \e[0m"
sudo apt-get update
sudo apt-get dist-upgrade -y

echo -e "\e[1;36m Waveshare_fbcp DRIVER FOR 2INCH DISPLAY  \e[0m"
sudo apt-get install cmake p7zip-full gcc git build-essential -y
sudo mkdir /opt/vc/include
git clone https://github.com/syproduction/ipodrpi
sudo cp -r ~/ipodrpi/include /opt/vc/

cd ~
wget https://www.waveshare.com/w/upload/8/8d/Waveshare_fbcp-main.7z
7z x Waveshare_fbcp-main.7z
cd waveshare_fbcp-main
mkdir build
cd build
cmake -DSPI_BUS_CLOCK_DIVISOR=20 -DWAVESHARE_2INCH_LCD=ON -DBACKLIGHT_CONTROL=ON -DSTATISTICS=0 ..
make -j
sudo ./fbcp&

echo -e "\e[1;36m DISPLAY SHOULD SHOW SOMETHING NOW \e[0m"
echo -e "\e[1;36m DISPLAY AUTOSTART ON BOOT (/etc/rc.local METHOD) \e[0m"
sudo cp ~/waveshare_fbcp-main/build/fbcp /usr/local/bin/fbcp
sudo sed -i -e '$ i\fbcp&' /etc/rc.local

echo -e "\e[1;36m NOW INSTALL pikeyd \e[0m"
cd ~
sudo cp ~/ipodrpi/etc/pikeyd.conf /etc/pikeyd.conf
git clone git://github.com/mmoller2k/pikeyd
make -C pikeyd
sudo cp pikeyd/pikeyd /usr/local/bin/
sudo sed -i -e '$ i\/usr/local/bin/pikeyd -d' /etc/rc.local
echo -e "\e[1;36m pikeyd INSTALLED AS DAEMON (/etc/rc.local METHOD) \e[0m"

echo -e "\e[1;36m NOW INSTALLING pigpio \e[0m"
sudo apt-get install -y python3-distutils
cd ~
wget https://github.com/joan2937/pigpio/archive/master.zip
unzip master.zip
cd pigpio-master
make
sudo make install

echo -e "\e[1;36m NOW INSTALLING click.c \e[0m"
cd ~
git clone https://github.com/WiringPi/WiringPi
cd ~/WiringPi/
./build
cd ~/ipodrpi
gcc -Wall -pthread -o click click.c -lpigpio -lrt -lwiringPi
sudo chmod +x click
sudo cp ~/ipodrpi/click /usr/local/bin/click
sudo cp ~/ipodrpi/system/click.sh /usr/local/bin/click.sh
sudo chmod +x /usr/local/bin/click.sh
sudo sed -i -e '$ i\/usr/local/bin/click.sh' /etc/rc.local


read -r -p "CHANGE CONSOLE FONT TO BIGGER ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
sudo cp ~/ipodrpi/system/console-setup /etc/default/console-setup
sudo /etc/init.d/console-setup.sh restart
else
echo Skipping..
fi

read -r -p "CREATIVE SOUNDBLASTER PLAY! ALSA SETUP ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
sudo cp ~/ipodrpi/system/alsa-base.conf /etc/modprobe.d/alsa-base.conf
else
echo Skipping..
fi

read -r -p " CMUS ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
echo -e "\e[1;36m OK \e[0m"
sudo apt-get install cmus -y
sudo rm /etc/pikeyd.conf
sudo cp ~/ipodrpi/etc/pikeyd.conf.cmus /etc/pikeyd.conf
cmus &
cmus-remote -C "bind -f common u shell ~/.config/cmus/cmus-update.sh" &
cmus-remote -C "set softvol=true" &
sudo killall cmus
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

read -r -p "ncmpcpp ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
echo -e "\e[1;36m OK, ncmpcpp WILL START AT BOOT \e[0m"
sudo apt-get install -y mpd mpc ncmpcpp
sudo rm /etc/mpd.conf
sudo cp ~/ipodrpi/etc/mpd.conf /etc/mpd.conf
sudo mkdir ~/Music
sudo mkdir ~/Music/playlists
sudo ln -s ~/Music /var/lib/mpd/Music
#sudo ln -s ~/Music/playlists /var/lib/mpd/Music/playlists
mpc update
sudo rm /etc/pikeyd.conf
sudo cp ~/ipodrpi/etc/pikeyd.conf.ncmpcpp /etc/pikeyd.conf
echo "mpc update" >> ~/.bashrc
echo "ncmpcpp" >> ~/.bashrc
else
echo Skipping..
fi

read -r -p "TUNE VOLUME IN ALSAMIXER ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
echo -e "\e[1;36m UP/DOWN arrow keys to tune volume, ESC to exit \e[0m"
alsamixer
else
echo Skipping..
fi

read -r -p "CLEANUP ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
echo -e "\e[1;36m OK, CLEANING ~ \e[0m"
sudo rm -r ~/ipodrpi
sudo rm -r ~/pigpio-master
sudo rm -r waveshare_fbcp-main
sudo rm -r WiringPi
sudo rm pikeyd
sudo rm Waveshare_fbcp-main.7z
else
echo Skipping..
fi

echo -e "\e[1;36m DONE. PLEASE REBOOT NOW \e[0m"
read -r -p "REBOOT ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
echo -e "\e[1;36m OK, REBOOTING  \e[0m"
sudo reboot now
else
echo Skipping..
fi
