# ipodrpi
Classic iPod mod with Raspberry Pi Zero and color screen. Suitable for OSMC and plain Raspbian install.

# Install

OSMC: 
- Burn SD card with Raspberry Pi Imager (OSMC PI 0/1)
- Start Raspberry with SD inside, go through initial OSMC, (with hdmi display and keyboard) connect to WIFI and ensure SSH is on.
- SSH to RPi from computer or on RPi go to Power > Exit and smash ESC key on keyboard until you get into shell. Default credentials: osmc : osmc

RASPBIAN: 
- Burn SD card with Raspberry Pi Imager > Raspberry Pi OS (32-bit)
- Put empty file named "ssh" on SD 
- Fill your WIFI name and password in wpa_supplicant.conf and put it on SD
- Insert your SD in RPi and power it on
- SSH to RPi from computer. Default credentials: pi:raspberry

Type 3 commands:
```
wget https://raw.githubusercontent.com/syproduction/ipodrpi/main/cli.sh
sudo chmod +x ./cli.sh
./cli.sh
```
Ssh on computer (Mac) may refuse to connect if you were previously connecting to this RPi, then:
```
rm ~/.ssh/known_hosts
```
# Caution
Answer honestly on script question OSMC? Because on OSMC we need to disable OSMC repository to sucessfully APT-GET DIST-UPGRADE. When OSMC repository enabled, it fails with upgrading libc6.

# What gives

Script will install everything you need to get Raspberry Pi Zero W working with 2 inch Waveshare 320x240 display and iPod's clickwheel.

- Clickwheel    Keyboard
- Scroll CCW  = KEY_UP
- Scroll CW   = KEY_DOWN
- LEFT        = KEY_PREVIOUSSONG
- RIGHT       = KEY_NEXTSONG
- UP          = KEY_ESC
- DOWN        = KEY_PLAYPAUSE
- CENTER      = KEY_ENTER

# Whats inside
1. Disables OSMC repository of APT because it gives errors with libc6. You can add it later to /etc/apt/sources.list (deb http://apt.osmc.tv buster main)
2. Apt update & upgrade
3. Waveshare 2 inch 320x240 FBCP driver 
4. PiGPIO
5. wiringPi
6. click.c + pigpio abomination
7. CMUS

# Wiring

<img width="300" alt="Screen Shot 2021-10-19 at 12 40 11 PM" src="https://user-images.githubusercontent.com/26803370/137865049-eb68ea79-724c-4ad0-b095-4171e9a41267.png">

![SpotifyPod_schematicsclickwheel-1536x1242](https://user-images.githubusercontent.com/26803370/137865290-7cd4b812-71f0-4c6b-b2e4-2a74a8433b52.png)


# Mentions
- Guy Dupont (https://github.com/dupontgu/retro-ipod-spotify-client) for inspiration and click.c rework of:
- Jason Garr (https://jasongarr.wordpress.com/project-pages/ipod-clickwheel-hack/) for clickwheel hacking

