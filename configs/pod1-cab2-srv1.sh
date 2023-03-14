#!/bin/bash

# NEW WAY
# setup untagged on team0
sudo ip address add 192.168.0.2/28 dev team0
sudo ip link set team0 up

# setup a vlan on team0
sudo vconfig add team0 200
sudo ifconfig team0.200 10.200.200.22 netmask 255.255.255.0
sudo ip link set team0.200 up

# Add route pointing to vl200 agw on the leaf switch
sudo ip route add 10.0.0.0/8 via 10.200.200.254 dev team0.200

# OLD WAY
# cat > /etc/network/interfaces << EOF
# auto eth1
# iface eth1 inet static
#   # 10.{pod}.{leaf}.{nextfree}/30
#   #address 10.1.1.6
#   #netmask 255.255.255.254
#   address 192.168.0.2
#   netmask 255.255.255.248
# #iface eth1 inet6 static
#   # fd00:{pod}{leaf}::{port}:{vrf}:1/64
#   #address fd00:11::2:100:2
#   #netmask 64
#   #pre-up echo 0 > /proc/sys/net/ipv6/conf/eth1/accept_ra

# auto eth2
# iface eth2 inet static
#   # 10.{pod}.{leaf}.{nextfree}/30
#   #address 10.1.2.6
#   #netmask 255.255.255.254
#   address 192.168.0.10
#   netmask 255.255.255.248
# #iface eth2 inet6 static
#   # fd00:{pod}{leaf}::{port}:{vrf}:1/64
#   #address fd00:12::2:100:2
#   #netmask 64
#   #pre-up echo 0 > /proc/sys/net/ipv6/conf/eth1/accept_ra
# EOF

# ifup eth1
# ifup eth2
