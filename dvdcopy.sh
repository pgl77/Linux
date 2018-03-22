#!/bin/bash
# https://ryanstutorials.net/bash-scripting-tutorial/bash-script.php
echo "Script to determine dvd size and then copy iso file to Videos"
sleep 2
#get active window ID
varactwindow=$(xdotool getactivewindow)
#open vlc in background appears to help decoding
# open vlc in xterm window - & causes it to run background
xterm -e vlc dvd:///dev/sr0 &
sleep 10 #ensure vlc has time to process dvd
# xterm -e vlc dvd:///dev/sr0  --qt-start-minimized & #try to get minimize on start (also no voluem control anymore)
#Return focus to terminal
xdotool windowactivate $varactwindow
#Determine volume and block size
#isoinfo -d -i /dev/sr0 | grep -i -E 'block size|volume size'
#above lien is original info source for manual manipulation
varblocksize=$(isoinfo -d -i /dev/sr0 | grep -i -E 'block size')
varvolumesize=$(isoinfo -d -i /dev/sr0 | grep -i -E 'volume size')
#now manipulate strings to integers only
echo $varblocksize #print unedited info
varblocksize=${varblocksize##L*:} #truncate string
varvolumesize=${varvolumesize##V*:}
echo Block size is $varblocksize 
echo Volume size is $varvolumesize
echo $varblocksize 
echo $varvolumesize
#ask user for iso filename
echo Please provide filename for DVD image
read isoname
echo File will be named $isoname.iso
cd ~/Videos/
#hard wired block size
#sudo dd if=/dev/sr0 of=~/Videos/SimpsonsS5D3.iso bs=2048 count=4078429 status=progress
# status progress, continue even if error experienced
sudo dd if=/dev/sr0 of=~/Videos/${isoname}.iso conv=noerror status=progress #bs=$varblocksize count=$varvolumesize 
##############
#Rip successful
echo dvd copy complete
#close vlc and corresponding xterm
killall vlc
canberra-gtk-play --file=/usr/share/sounds/gnome/default/alerts/bark.ogg 
# 3 barks to let us know
sleep 1
echo 1
canberra-gtk-play --file=/usr/share/sounds/gnome/default/alerts/bark.ogg
sleep 1
echo 2
canberra-gtk-play --file=/usr/share/sounds/gnome/default/alerts/bark.ogg
sleep 1
echo 3
echo ejecting dvd...
sleep 1
eject /dev/sr0

