#!/bin/bash


# OSMC iPod Raspberry Pi with 2 inch LCD installer 
# by DARKMATTERWORKS
# https://osmc.tv/download/ or 
# https://www.raspberrypi.com/software/
# burn SD on computer
# Boot from SD on RPi and config region/networking with TV/keyboard
# After this you can ssh from computer to OSMC Rpi
# 
# rm ~/.ssh/known_hosts
#deb http://apt.osmc.tv buster main



echo -e "\e[1;36m DISABLING OSMC REPOSITORY (BECAUSE OF LIBC6 ERROR)  \e[0m"  
sudo bash -c 'echo "deb http://mirrordirector.raspbian.org/raspbian buster main contrib non-free rpi" > /etc/apt/sources.list'

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
sudo sed -i -e '$ i\click&' /etc/rc.local

echo -e "\e[1;36m DONE. PLEASE REBOOT NOW \e[0m"  


