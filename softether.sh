#!/usr/local/env bash
# Register digitalocean with free credit https://m.do.co/c/4879bb02d178
# Create vps with 5usd price
# Update system
apt-get update && apt-get -y upgrade

# Get build tools
apt-get -y install build-essential wget curl gcc make wget tzdata git libreadline-dev libncurses-dev libssl-dev zlib1g-dev

# Define softether version
RTM=$(curl http://www.softether-download.com/files/softether/ | grep -o 'v[^"]*e' | grep rtm | tail -1)
IFS='-' read -r -a RTMS <<< "${RTM}"

# Get softether source
wget "http://www.softether-download.com/files/softether/${RTMS[0]}-${RTMS[1]}-${RTMS[2]}-${RTMS[3]}-${RTMS[4]}/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${RTMS[0]}-${RTMS[1]}-${RTMS[2]}-${RTMS[3]}-linux-x64-64bit.tar.gz" -O /tmp/softether-vpnserver.tar.gz

# Extract softether source
tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/

# Remove unused file
rm /tmp/softether-vpnserver.tar.gz

# Move to source directory
cd /usr/local/vpnserver

# Build softether
make i_read_and_agree_the_license_agreement

# Change file permission
chmod 0600 * && chmod +x vpnserver && chmod +x vpncmd

# Link binary files
ln -s /usr/local/vpnserver/vpnserver /usr/local/bin/vpnserver
ln -s /usr/local/vpnserver/vpncmd /usr/local/bin/vpncmd

# Add systemd service
cat <<EOF >/lib/systemd/system/vpnserver.service
[Unit]
Description=SoftEther VPN Server
After=network.target
ConditionPathExists=!/usr/local/vpnserver/do_not_run

[Service]
Type=forking
ExecStart=/usr/local/vpnserver/vpnserver start
ExecStop=/usr/local/vpnserver/vpnserver stop
KillMode=process
Restart=on-failure
WorkingDirectory=/usr/local/vpnserver

# Hardening
PrivateTmp=yes
ProtectHome=yes
ProtectSystem=full
ReadOnlyDirectories=/
ReadWriteDirectories=-/usr/local/vpnserver
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_BROADCAST CAP_NET_RAW CAP_SYS_NICE CAP_SYS_ADMIN CAP_SETUID

[Install]
WantedBy=multi-user.target
EOF

# Act as router
echo net.ipv4.ip_forward = 1 | sudo tee -a /etc/sysctl.conf
sysctl -p

# Reload service
systemctl daemon-reload
# Enable service
systemctl enable vpnserver
# Start service
systemctl restart vpnserver

# Init config vpnserver
# > cd /usr/local/vpnserver
# > ./vpncmd
# > ServerPasswordSet yourPassword
# Then use SoftEther VPN Server Manager to mange your server

exit 0