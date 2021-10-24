sudo apt-get update
sudo apt-get dist-upgrade -y

git clone git://git.rockbox.org/rockbox

sudo apt-get install -y zip flex bison libtool-bin texinfo mpc libgmp3-dev libmpfr-dev libmpfr-doc libsdl1.2-dev libsdl-image1.2-dev libsdl-ttf2.0-dev libxrandr-dev


cd ~/rockbox/tools
sudo ./rockboxdev.sh
#a -choose
./rockboxui --nobackground --zoom 2

export PATH="~/rockbox:$PATH"
~/rockbox/rockboxui --nobackground --zoom 2.5

/usr/local/bin/rock.sh
~/.config/autostart


mkdir /ram
sudo mount -osize=100m tmpfs /ram -t tmpfs


sudo systemctl enable vncserver-x11-serviced
sudo vncpasswd -service
sudo systemctl restart vncserver-x11-serviced
sudo journalctl -u vncserver-x11-serviced.service

#pipod
sudo apt-get install -y python-pip python3-pip vlc
sudo apt-get install python-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev libsdl1.2-dev libsmpeg-dev python-numpy subversion libportmidi-dev ffmpeg libswscale-dev libavformat-dev libavcodec-dev libfreetype6-dev alsa-base pulseaudio libtag1-dev libsdl2-ttf-2.0-0

sudo pip3 install python-vlc
sudo pip install pygame
sudo pip3 install pytaglib
sudo pip3 install freetype-py


KEY_PREVIOUSSONG        0 //left
KEY_NEXTSONG    1       //right
KEY_ESC         16      //up
KEY_PLAYPAUSE   6       //down
KEY_ENTER       13      //center
KEY_DOWN        12      //ccw
KEY_UP          20      //cw
