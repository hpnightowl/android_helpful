#!/bin/bash

echo "====================Build Environment Rom========================"
sudo apt-get update
sudo apt-get install -y bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev unzip openjdk-8-jdk libssl-dev python ccache libtinfo5
sudo apt-get upgrade -y

echo "================== INSTALLING GIT-REPO ========================== "
wget https://storage.googleapis.com/git-repo-downloads/repo
chmod a+x repo
sudo install repo /usr/local/bin/repo

echo -e "\n================== CONFIGURING GIT ==================\n"
git config --global user.email "iamhp2k@gmail.com"
git config --global user.name "hpnightowl"
