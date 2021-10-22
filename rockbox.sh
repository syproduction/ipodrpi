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


