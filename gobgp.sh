#!/bin/bash
# configure IP address
ip address add dev eth1 192.168.22.1/24

# add gobpg config
cat <<EOF >> /gobgp.yml
global:
  config:
    as: 4200000000
    router-id: 10.0.0.3
neighbors:
  - config:
      neighbor-address: 192.168.22.2
      peer-as: 4200000000
    afi-safis:
      - config:
          afi-safi-name: ipv4-unicast
EOF

# start gobgpd daemon
gobgpd -t yaml -f /gobgp.yml &
sleep 5

# make ipv4 BGP announcement
attr_v4="
  -a ipv4 \
  identifier 1 \
  origin igp \
  nexthop 192.168.22.1 \
  community 1:1,2:2 \
"

# Populate prefixes
gobgp global rib add 192.168.100.1/32 $attr_v4
