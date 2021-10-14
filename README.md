# ipodrpi
Classic iPod mod with Raspberry Pi Zero and color screen

- Currently installs everything right but clickwheel buttons not working. 
- FBCP process need to restart after desktop


# Install

Burn SD card with Raspberry Pi Imager (OSMC PI 0/1) 
Start Raspberry with SD inside, go through initial OSMC, connect to WIFI.

SSH to RPi from computer or on RPi go to Power > Exit and smash ESC key on keyboard until you get into shell.
Default credentials: osmc : osmc

Type:
```
wget https://raw.githubusercontent.com/syproduction/ipodrpi/main/osmc.sh
./osmc.sh
```
If any problems with Permission denied or command not found, do:
```
sudo chmod +x ./osmc.sh
```
Ssh on computer (Mac) may refuse to connect if you were previously connecting to this RPi, then:
```
rm ~/.ssh/known_hosts
```
# Whats inside
1. Disables OSMC repository of APT because it gives errors with libc6. You can add it later to /etc/apt/sources.list (deb http://apt.osmc.tv buster main)
2. Apt update & upgrade
3. Waveshare 2 inch 320x240 FBCP driver 
4. PiGPIO
5. wiringPi
6. click.c + pigpio abomination

# Wiring
Perfectly described here: http://rsflightronics.com/spotifypod

# Mentions
- Guy Dupont (https://github.com/dupontgu/retro-ipod-spotify-client)for inspiration and click.c rework of:
- Jason Garr (https://jasongarr.wordpress.com/project-pages/ipod-clickwheel-hack/) for clickwheel hacking

