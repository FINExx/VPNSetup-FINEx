#!/bin/bash
echo "Removing Old Theme"
rm -rf /home/vps/public_html/asset
rm -rf /home/vps/public_html/view
rm -rf /home/vps/public_html/tmp/*
echo "Installing NoypiSSH Theme"
cd ~
mkdir M4rshall
cd M4rshall
rm -rf *
apt-get install unzip -y
wget https://raw.githubusercontent.com/FINExx/VPNSetup-FINEx/master/NoypiSSH.zip && unzip NoypiSSH.zip
mv asset /home/vps/public_html
mv view /home/vps/public_html
echo "Enjoy using NoypiSSH Theme -M4rshall"
