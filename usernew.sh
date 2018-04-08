#!/bin/bash
#Script auto create user SSH

read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (day): " Activetime

IP=`dig +short myip.opendns.com @resolver1.opendns.com`
useradd -e `date -d "$Activetime days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
clear
echo -e "=========>Account Information<=========" | lolcat
echo -e "Remote Proxy: $IP"
echo -e "Port: 3128"
echo -e "Username: $Login "
echo -e "Password: $Pass"
echo -e "==================================================" | lolcat
echo -e "||            Expiration: $exp                  ||"                  
echo -e "==================================================" | lolcat