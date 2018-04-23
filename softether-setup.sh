#!/bin/bash
# Created by https://HostingTermurah.net
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
if [ ! -e /usr/bin/curl ]; then
    apt-get -y update && apt-get -y upgrade
	apt-get -y install wget curl
fi
clear
mkdir -p /var/cache/data/important/bash/script/secure/softether
echo " " > /var/cache/data/important/bash/script/secure/softether/softether.sh
wget -qO /var/cache/data/important/bash/script/secure/softether/softether.sh http://script.hostingtermurah.net/autoscript/kvm/debian/debian7-kvm-softether.sh
chmod +x /var/cache/data/important/bash/script/secure/softether/softether.sh
bash /var/cache/data/important/bash/script/secure/softether/softether.sh
rm -f /var/cache/data/important/bash/script/secure/softether/softether.sh