#!/usr/bin/env bash

# Exit upon errors
set -e

echo "Test that pod1-srv1 can ping pod2-srv1 on both untagged and vlan 200"
docker exec -it clab-dc1-pods-pod1-cab1-srv1 ping -c3 -w1 192.168.0.2
docker exec -it clab-dc1-pods-pod1-cab1-srv1 ping -c3 -w1 10.200.200.22

echo "Same for cab1->cab3"
docker exec -it clab-dc1-pods-pod1-cab1-srv1 ping -c3 -w1 192.168.0.3
docker exec -it clab-dc1-pods-pod1-cab1-srv1 ping -c3 -w1 10.200.200.33

echo "and cab2->cab3, both ways"
docker exec -it clab-dc1-pods-pod1-cab2-srv1 ping -c3 -w1 192.168.0.3
docker exec -it clab-dc1-pods-pod1-cab3-srv1 ping -c3 -w1 10.200.200.22

exit 0
